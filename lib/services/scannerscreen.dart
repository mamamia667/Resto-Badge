import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:go_router/go_router.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen>
  with WidgetsBindingObserver {
  
  late final MobileScannerController _controller;
  StreamSubscription<Object?>? _subscription;
  bool _torchOn = false;

  @override
  void initState() {
    super.initState();
      //initialisation
    _controller = MobileScannerController(
      autoStart: false,
      // Les formats de codebar 
      formats: const [
        BarcodeFormat.qrCode,
        BarcodeFormat.ean13,
        BarcodeFormat.ean8,
        BarcodeFormat.code128,
        BarcodeFormat.code39,
        BarcodeFormat.upcA,
        BarcodeFormat.upcE,
      ],
      torchEnabled: false,
    );

    // Ecoutez les changements  
    WidgetsBinding.instance.addObserver(this);

    // ecoute les évennements & active scanner
    _subscription = _controller.barcodes.listen(_onBarcodeDetected);
    unawaited(_controller.start());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_controller.value.hasCameraPermission) return;
      //vérifie l'état du scanner pour pouvoir le fermer en arrière plan
    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        _subscription = _controller.barcodes.listen(_onBarcodeDetected);
        unawaited(_controller.start());
      case AppLifecycleState.inactive:
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(_controller.stop());
    }
  }

  void _onBarcodeDetected(BarcodeCapture capture) {
    final barcode = capture.barcodes.firstOrNull;
    if (barcode == null) return;

    final value = barcode.rawValue;
    if (value == null) return;

    // Stop scanner to avoid repeated detections
    unawaited(_controller.stop());

    // Show result
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Scanned!'),//modifiable
        content: SelectableText(value),
        actions: [
          TextButton(
            onPressed: () {
              context.pop(context);
              unawaited(_controller.start()); // reprends le scan
            },
            child: const Text('Scan Again'),//modifiable
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, value),
            child: const Text('Done'),//modifiable
          ),
        ],
      ),
    );
  }
//activez la torche
  Future<void> _toggleTorch() async {
    await _controller.toggleTorch();
    setState(() => _torchOn = !_torchOn);
  }
//changer de camra
  Future<void> _switchCamera() async {
    await _controller.switchCamera();
  }
//libérez la caméra
  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_subscription?.cancel());
    _subscription = null;
    super.dispose();
    await _controller.dispose();
  }
//l'écran de scannn
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          color: Colors.white,
          icon : Icon(Icons.cancel),
          onPressed: () => context.go("/") ,
        ),
        actions: [
          IconButton(
            color: Colors.white,
            icon: Icon(_torchOn ? Icons.flash_on : Icons.flash_off),
            onPressed: _toggleTorch,
          ),
          // Switch camera
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.cameraswitch),
            onPressed: _switchCamera,
          ),
          
        ],
      ),
      body: Stack(
        
        children: [
          
          MobileScanner(
            controller: _controller,
          ),
          
          
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          // Hint text
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Text(
                'Scanner le code QR',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ),
        ],
      ), 
    );
  }
}