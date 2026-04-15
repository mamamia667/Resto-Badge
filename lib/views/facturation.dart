import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class Facturation extends StatefulWidget {
  const Facturation({super.key});

  @override
  State<Facturation> createState() => FacturationState();
}

class FacturationState extends State<Facturation> {
  bool isExpanded = true;
  final TextEditingController pinController = TextEditingController();

  // Détection du type d'appareil
  bool _isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= 600;

  //Enregistrement
  

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tablet = _isTablet(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── En-tête ───────────────────────────────────
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Facturation",
                  style: TextStyle(
                    fontSize: tablet ? 42 : 24,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () => context.go("/Dashboard"),
                  child: Text(
                    "Tableau de bord",
                    style: TextStyle(
                      fontSize: tablet ? 16 : 12,
                      color: Colors.blue,
                      //decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(thickness: 1, height: 30),

          // ─── Cartes statistiques responsive ──────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: tablet
                ? Row(
                    children: [
                      Expanded(child: _buildRepasCard(tablet)),
                      const SizedBox(width: 15),
                      Expanded(child: _buildQrCard(context, tablet)),
                    ],
                  )
                : Column(
                    children: [
                      _buildRepasCard(tablet),
                      const SizedBox(height: 12),
                      _buildQrCard(context, tablet),
                    ],
                  ),
          ),

          const SizedBox(height: 20),

          // ─── Carte Code Pin ────────────────────────────
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: /*tablet ? 650 :*/ double.infinity,
              ),
              child: Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ExpansionTile(
                    shape: const RoundedRectangleBorder(side: BorderSide.none),
                    collapsedShape: const RoundedRectangleBorder(side: BorderSide.none),
                    initiallyExpanded: true,
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: const EdgeInsets.only(bottom: 10),
                    title: Text(
                      "Entrez votre Code Pin ou \nle Token de Validation",
                      style: TextStyle(
                        fontSize: tablet ? 18 : 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Icon(
                      isExpanded ? Icons.remove_circle_outline : Icons.add_circle_outline,
                      color: Colors.blue,
                    ),
                    onExpansionChanged: (v) => setState(() => isExpanded = v),
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Code Pin ou Token *",
                          style: TextStyle(fontSize: tablet ? 14 : 11, color: Colors.grey[600]),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: pinController,
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "0000",
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4A9EE8),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          ),
                          onPressed: () {
                            // Action de validation
                          },
                          child: Text("Valider", style: TextStyle(fontSize: tablet ? 16 : 14)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ─── 10 dernières personnes ────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    tablet
                    ? Text(
                      "Les 10 derniers enregistrements",
                      style: TextStyle(
                        fontSize: tablet ? 18 : 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ):Text(
                      "Les 5 derniers enregistrements",
                      style: TextStyle(
                        fontSize: tablet ? 18 : 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        "Aucun étudiant trouvé",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: tablet ? 15 : 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // --- Widget helper pour la carte Repas ---
  Widget _buildRepasCard(bool tablet) {
    return StatCard(
      color: Colors.redAccent,
      icon: Icons.coffee_outlined,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "Nombre de repas servis : --",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: tablet ? 16 : 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Service : Petit-déjeuner",
            style: TextStyle(fontSize: tablet ? 13 : 11, color: Colors.blue[800]),
          ),
          Text(
            "Prix : 0.00 FCFA",
            style: TextStyle(fontSize: tablet ? 13 : 11, color: Colors.blue[800]),
          ),
        ],
      ),
    );
  }

  // --- Widget helper pour la carte QR ---
  Widget _buildQrCard(BuildContext context, bool tablet) {
    return StatCard(
      color: Colors.blueAccent,
      icon: Icons.qr_code_scanner,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: tablet ? 40 : 32,
            child: OutlinedButton.icon(
              icon: Icon(Icons.center_focus_weak, size: tablet ? 20 : 16),
              label: const Text("Lecture"),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF4A9EE8),
                side: const BorderSide(color: Color(0xFF4A9EE8)),
                padding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              onPressed: () => context.go("/scanner"),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Scanner un code QR",
            style: TextStyle(fontSize: tablet ? 13 : 10, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

// --- Widget StatCard réutilisable ---
class StatCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final Widget child;

  const StatCard({
    super.key,
    required this.color,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final tablet = MediaQuery.of(context).size.shortestSide >= 600;
    // Hauteurs ajustées pour éviter les débordements
    final cardHeight = tablet ? 120.0 : 95.0; 
    final iconSize = tablet ? 48.0 : 32.0;

    return Row(
      children: [
        Container(
          height: cardHeight,
          width: tablet ? 100 : 75,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
          ),
          child: Icon(icon, size: iconSize, color: Colors.white),
        ),
        Expanded(
          child: Container(
            height: cardHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(child: child),
          ),
        ),
      ],
    );
  }
}