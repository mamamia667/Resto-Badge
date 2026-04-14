import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class NoPermissionScreen extends StatelessWidget {
  const NoPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Icône ───────────────────────────────────────────
              const Icon(
                Icons.no_photography_outlined,
                color: Colors.white54,
                size: 80,
              ),
              const SizedBox(height: 24),

              // ── Titre ────────────────────────────────────────────
              const Text(
                "Accès à la caméra refusé",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              // ── Description ──────────────────────────────────────
              const Text(
                "Cette application a besoin de la caméra pour scanner "
                "les codes QR. Veuillez autoriser l'accès.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),

              // ── Bouton principal ──────────────────────────────────
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.camera_alt),
                  label: const Text("Autoriser la caméra"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A9EE8),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    final status = await Permission.camera.request();

                    if (status.isGranted) {
                      //  Accordée → ValueListenableBuilder bascule automatiquement
                    } else if (status.isPermanentlyDenied) {
                      // Permanente → paramètres système
                      await openAppSettings();
                    }
                    // isDenied → reste sur NoPermissionScreen
                  },
                ),
              ),
              const SizedBox(height: 12),

              // ── Bouton paramètres (secours) ───────────────────────
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.settings),
                  label: const Text("Ouvrir les paramètres"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white38),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    await openAppSettings();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}