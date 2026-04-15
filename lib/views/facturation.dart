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

  bool _isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= 600;

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
            padding: const EdgeInsets.only(top: 5, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Facturation",
                  style: TextStyle(
                    fontSize: tablet ? 42 : 28, // ← réduit : 52/36 → 42/28
                    color: Colors.grey,
                  ),
                ),
                GestureDetector(
                  onTap: () => context.go("/Dashboard"),
                  child: const Text(
                    "Tableau de bord",
                    style: TextStyle(fontSize: 12, color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),

          const Divider(thickness: 1),
          const SizedBox(height: 10),

          // ─── Cartes statistiques ───────────────────────
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final tablet = constraints.maxWidth >= 600;
                return GridView.count(
                  crossAxisCount: tablet ? 2 : 1,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: tablet ? 3.5 : 3.8, // ← légèrement ajusté
                  children: [

                    // Carte repas servis
                    StatCard(
                      color: Colors.red,
                      icon: Icons.coffee_outlined,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          FittedBox( // ← CORRECTION overflow : FittedBox sur chaque Text
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "Nombre de repas servis : Données",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "Service en cours : Données",
                              style: TextStyle(fontSize: 11, color: Colors.blue),
                            ),
                          ),
                          SizedBox(height: 2),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "Prix : Données",
                              style: TextStyle(fontSize: 11, color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Carte QR code
                    StatCard(
                      color: Colors.blue,
                      icon: Icons.qr_code_2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            style: ButtonStyle(
                              foregroundColor: WidgetStateProperty.resolveWith<Color?>(
                                (s) => s.contains(WidgetState.pressed)
                                    ? Colors.white
                                    : const Color(0xFF4A9EE8),
                              ),
                              backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                                (s) => s.contains(WidgetState.pressed)
                                    ? const Color(0xFF4A9EE8)
                                    : Colors.transparent,
                              ),
                              side: WidgetStateProperty.all(
                                const BorderSide(color: Color(0xFF4A9EE8), width: 1.5),
                              ),
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3)),
                              ),
                            ),
                            onPressed: () => context.go("/scanner"),
                            child: const Text("Lecture"),
                          ),
                          const SizedBox(height: 4),
                          const FittedBox( // ← CORRECTION overflow
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "Cliquez pour lire le QR",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 10, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          // ─── Carte Code Pin ────────────────────────────
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: tablet ? 600 : double.infinity,
              ),
              child: Card(
                elevation: 11,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ExpansionTile(
                    initiallyExpanded: true,
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 8.0),
                    shape: const RoundedRectangleBorder(side: BorderSide.none),
                    collapsedShape:
                        const RoundedRectangleBorder(side: BorderSide.none),
                    title: const Text(
                      "Entrez votre Code Pin ou le Token de Validation",
                      style: TextStyle(fontSize: 14), // ← réduit légèrement
                    ),
                    trailing: Icon(
                      isExpanded ? Icons.remove : Icons.add,
                      color: Colors.grey,
                    ),
                    onExpansionChanged: (v) =>
                        setState(() => isExpanded = v),
                    children: [
                      const ListTile(
                          title: Text("Code Pin ou le Token *")),
                      const SizedBox(height: 3),
                      TextField(
                        controller: pinController,
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 14),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          style: ButtonStyle(
                            foregroundColor:
                                const WidgetStatePropertyAll(Colors.white),
                            backgroundColor: const WidgetStatePropertyAll(
                                Color(0xFF4A9EE8)),
                            side: WidgetStateProperty.all(
                              const BorderSide(
                                  color: Color(0xFF4A9EE8), width: 1.5),
                            ),
                            shape: WidgetStateProperty.resolveWith(
                              (s) => RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                          onPressed: () {
                            // TODO : vérifier le token
                          },
                          child: const Text("Valider"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // ─── 10 dernières personnes ────────────────────
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: double.infinity),
              child: Card(
                elevation: 11,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                            "Les 10 dernières personnes enregistrées"),
                      ),
                      Center(
                        child: Text(
                          "Aucun étudiant trouvé",
                          style:
                              TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}


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

  bool _isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= 600;

  @override
  Widget build(BuildContext context) {
    final tablet = _isTablet(context);
    final cardHeight = tablet ? 110.0 : 90.0; // ← réduit : 120/100 → 110/90
    final iconSize = tablet ? 44.0 : 32.0;    // ← réduit : 50/36 → 44/32

    return Row(
      children: [
        // ── Icône colorée ──────────────────────────────
        Container(
          height: cardHeight,
          width: cardHeight,
          color: color,
          child: Center(
            child: Icon(icon, size: iconSize, color: Colors.white),
          ),
        ),

        // ── Contenu ────────────────────────────────────
        Expanded(
          child: Container(
            height: cardHeight,
            color: Colors.white70,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6), // ← padding vertical ajouté
            child: child,
          ),
        ),
      ],
    );
  }
}