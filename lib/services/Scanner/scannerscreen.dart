import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart'; 
import 'package:restobadge/services/Scanner/NoPermissionScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> with WidgetsBindingObserver {
  final MobileScannerController _controller = MobileScannerController(
    autoStart: false,
    torchEnabled: false,
  );
  
  bool _torchOn = false;
  bool _isScannerReady = false;
  bool _isRedirecting = false; // Sécurité pour ne pas lancer l'URL 100 fois

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkPermissionAndStart();
  }

  Future<void> _checkPermissionAndStart() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
    }
    if (status.isGranted) {
      try {
        await _controller.start();
        if (mounted) setState(() => _isScannerReady = true);
      } catch (e) {
        debugPrint("Erreur caméra : $e");
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkPermissionAndStart();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double scanAreaSize = 260;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Scanner avec détection optimisée
          MobileScanner(
            controller: _controller,
            
            onDetect: (capture) async {
              if (_isRedirecting) return; // Si on est déjà en train de rediriger, on stoppe

              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
                _isRedirecting = true; // On verrouille
                final String code = barcodes.first.rawValue!;
                
                await _controller.stop(); // On stop la caméra immédiatement

                final Uri url = Uri.parse(code);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                } else {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Contenu scanné : $code')),
                    );
                    // On déverrouille et redémarre si ce n'est pas une URL pour permettre un autre scan
                    _isRedirecting = false;
                    _controller.start();
                  }
                }
              }
            },
            errorBuilder: (context, error) {
              if (error.errorCode == MobileScannerErrorCode.permissionDenied) {
                return const NoPermissionScreen();
              }
              return const Center(child: Icon(Icons.error, color: Colors.white));
            },
          ),

          // 2. Overlay sombre (le trou central)
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha:0.7),
              BlendMode.srcOut,
            ),
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    backgroundBlendMode: BlendMode.dstOut,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: scanAreaSize,
                    width: scanAreaSize,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.zero, 
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 3. Coins du viseur (Painter)
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: scanAreaSize,
              width: scanAreaSize,
              child: CustomPaint(painter: ScannerOverlayPainter()),
            ),
          ),

          // 4. Bouton Fermer
          Positioned(
            top: 60,
            left: 20,
            child: GestureDetector(
              onTap: () => context.go("/"),
              behavior: HitTestBehavior.opaque, 
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.close, color: Colors.white, size: 28),
              ),
            ),
          ),
          
          // 5. Texte "Aligner" et Bouton Flash
          Positioned(
            bottom: 20, // Ajusté pour remonter un peu l'ensemble
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Texte avec padding pour l'espacement
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    "Alignez le code QR pour scanner",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5
                    ),
                  ),
                ),
                const SizedBox(height: 40), // Espace entre le texte et le bouton
                GestureDetector(
                  onTap: () async {
                    if (_isScannerReady) {
                      await _controller.toggleTorch();
                      setState(() => _torchOn = !_torchOn);
                    }
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    height: 64,
                    width: 64,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha:0.15),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white24, width: 1),
                    ),
                    child: Icon(
                      _torchOn ? Icons.flash_on : Icons.flash_off,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// Painter identique (inchangé)
class ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    final double cornerSize = 20;
    final path = Path();
    path.moveTo(0, cornerSize); path.lineTo(0, 0); path.lineTo(cornerSize, 0);
    path.moveTo(size.width - cornerSize, 0); path.lineTo(size.width, 0); path.lineTo(size.width, cornerSize);
    path.moveTo(size.width, size.height - cornerSize); path.lineTo(size.width, size.height); path.lineTo(size.width - cornerSize, size.height);
    path.moveTo(cornerSize, size.height); path.lineTo(0, size.height); path.lineTo(0, size.height - cornerSize);
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}