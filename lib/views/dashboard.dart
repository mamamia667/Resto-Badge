import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  // --- ÉTAT DU DROPDOWN ---
  final int startYear = 2017;
  final int currentYear = DateTime.now().year;
  //Controller Recherche

  // Initialisation des listes avec les labels "Cancel"
  late List<String> years = [
    "Année", 
    ...List.generate((currentYear - startYear) + 2, (index) => (startYear + index).toString())
  ];

  static const List<String> mois = [
    "Mois",
    "Janvier", "Février", "Mars", "Avril", "Mai", "Juin",
    "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"
  ];

  // Valeurs par défaut sur les labels
  String selectedYear = "Année";
  String selectedMonth = "Mois";

  bool isExpanded = true;

  // Détection du type d'appareil
  bool _isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= 600;

  @override
  Widget build(BuildContext context) {
    final tablet = _isTablet(context);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── En-tête ───────────────────────────────────
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 15),
            child: Text(
              "Dashboard",
              style: TextStyle(
                fontSize: tablet ? 42 : 24,
                color: Colors.grey[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          const Divider(thickness: 1, height: 30),

          // ─── Cartes statistiques responsive ──────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: tablet
                ? Row(
                    children: [
                      Expanded(child: _buildStatCardPDej(tablet)),
                      const SizedBox(width: 5),
                      Expanded(child: _buildStatCardDej(tablet)),
                      const SizedBox(width: 5),
                      Expanded(child: _buildStatCardDiner(tablet)),
                      const SizedBox(width: 5),
                      Expanded(child: _buildStatCardTotal(tablet))
                    ],
                  )
                  : Column( //une ROW avec un singlechildscroll Axis horizontal 
                    children: [
                      // Note: Suppression des Expanded ici pour éviter le crash de rendu
                      _buildStatCardPDej(tablet),
                      const SizedBox(height: 8),
                      _buildStatCardDej(tablet),
                      const SizedBox(height: 8),
                      _buildStatCardDiner(tablet),
                      const SizedBox(height: 8),
                      _buildStatCardTotal(tablet)
                    ],
                  ),
          ),

          const SizedBox(height: 15),

          // ─── Sélecteur de Date (Bilan Mensuel) ──────────
          Center(
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
                  title: Text(
                    "Sélectionner une Date pour afficher le bilan mensuel",
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
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Dropdown Années
                        _buildDropdownGroup("Années", selectedYear, years, (val) {
                          setState(() => selectedYear = val!);
                        }),
                        // Dropdown Mois
                        _buildDropdownGroup("Mois", selectedMonth, mois, (val) {
                          setState(() => selectedMonth = val!);
                        }),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          // --- Table de Données  ---
          
        

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // --- Helper pour construire les groupes de Dropdowns ---
  Widget _buildDropdownGroup(String label, String currentVal, List<String> items, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        DropdownButton<String>(
          value: currentVal,
          underline: Container(height: 1, color: Colors.blue.withValues(alpha: 0.3)),
          items: items.map((String value) {
            bool isResetLabel = (value == "Année" || value == "Mois");
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                  color: isResetLabel ? Colors.blueAccent : Colors.black,
                  fontWeight: isResetLabel ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  // --- Widgets helpers pour les cartes (Petit dej, Dej, Diner, Total) ---
  
  Widget _buildStatCardPDej(bool tablet) {
    DateTime date = DateTime.now();
    int monthInt = date.month; 
    String month = monthInt.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0'); 
    String year = date.year.toString();
    return StatCard(
      color: Colors.blueAccent,
      icon: Icons.coffee_outlined,
      child: _buildCardContent("0 couvert"," $day.$month.$year - PET-DEJ", tablet),
    );
  }

  Widget _buildStatCardDej(bool tablet) {
    DateTime date = DateTime.now();
    int monthInt = date.month; 
    String month = monthInt.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0'); 
    String year = date.year.toString();
    return StatCard(
      color: Colors.redAccent,
      icon: Icons.room_service,
      child: _buildCardContent("0 couvert", "$day.$month.$year - DEJEUNER", tablet),
    );
  }

  Widget _buildStatCardDiner(bool tablet) {
    DateTime date = DateTime.now();
    int monthInt = date.month; 
    String month = monthInt.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0'); 
    String year = date.year.toString();
    return StatCard(
      color: Colors.black,
      icon: Icons.restaurant_sharp,
      child: _buildCardContent("0 couvert", "$day.$month.$year - DINER", tablet),
    );
  }

  Widget _buildStatCardTotal(bool tablet) {
    DateTime date = DateTime.now();
    int monthInt = date.month; 
    String month = monthInt.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0'); 
    String year = date.year.toString();
    return StatCard(
      color: Colors.greenAccent,
      icon: Icons.bar_chart_sharp,
      child: _buildCardContent("0 couvert", "$day.$month.$year - TOTAL", tablet),
    );
  }

  Widget _buildCardContent(String title, String subtitle, bool tablet) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            title,
            style: TextStyle(fontSize: tablet ? 18 : 15, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(fontSize: tablet ? 11 : 8, color: Colors.grey[800]),
        ),
      ],
    );
  }
}

// ─── Widget StatCard Réutilisable ──────────────────────────
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