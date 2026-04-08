import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class Facturation extends StatefulWidget {
  const Facturation({super.key});

  @override
  State<Facturation> createState() => FacturationState();
}

class FacturationState extends State<Facturation> {
  // Afficher les fenêtres contextuelles
  bool isMenuActive = false;
  bool isPersonActive = false;
  bool isSearchActive = false;
  bool isSettingsActive = false;
  bool isAvatarActive = false;

  // ExpansionTile
  bool isExpanded = false;
//Controller du textField
final TextEditingController pinController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A9EE8),
        titleSpacing: 0,
        leadingWidth: 800,
        // On supprime le widget "leading" par défaut et on utilise "title"
        // pour placer le logo + boutons à gauche
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/inphblogo.png',
                height: 40,
              ),
              const SizedBox(width: 15),

            
              IconButton(
                icon: const Icon(Icons.menu_rounded, size: 15),
                onPressed: () {
                  setState(() {
                    isMenuActive = !isMenuActive;
                  });
                },
                style: ButtonStyle(
                  iconColor: WidgetStateColor.resolveWith((states) {
                    if (states.contains(WidgetState.pressed)) {
                      return const Color(0xFF4A9EE8); 
                    }
                    return Colors.white;
                  }),
                ),
              ),

              const SizedBox(width: 3),

            
              IconButton(
                icon: const Icon(Icons.person, size: 15),
                onPressed: () {
                  setState(() {
                    isPersonActive = !isPersonActive;
                  });
                },
                style: ButtonStyle(
                  iconColor: WidgetStateColor.resolveWith((states) {
                    if (states.contains(WidgetState.pressed)) {
                      return const Color(0xFF4A9EE8);
                    }
                    return Colors.white;
                  }),
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, size: 15),
            onPressed: () {
              setState(() {
                isSearchActive = !isSearchActive;
              });
            },
            style: ButtonStyle(
              iconColor: WidgetStateColor.resolveWith((states) {
                if (states.contains(WidgetState.pressed)) {
                  return const Color(0xFF4A9EE8);
                }
                return Colors.white;
              }),
            ),
          ),
          const SizedBox(width: 10),

          IconButton(
            icon: const Icon(Icons.settings, size: 15),
            onPressed: () {
              setState(() {
                isSettingsActive = !isSettingsActive;
              });
            },
            style: ButtonStyle(
              iconColor: WidgetStateColor.resolveWith((states) {
                if (states.contains(WidgetState.pressed)) {
                  return const Color(0xFF4A9EE8);
                }
                return Colors.white;
              }),
            ),
          ),
          const SizedBox(width: 10),

          GestureDetector(
            onTap: () {
              setState(() {
                isAvatarActive = !isAvatarActive;
              });
            },
            child: CircleAvatar(
              backgroundImage: const NetworkImage(""),
              radius: 20,
              onBackgroundImageError: (exception, stackTrace) {
              },
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── Barre latérale gauche ───────────────────────────────────
              SizedBox(
                width: 50,
                height: constraints.maxHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.speed_sharp),
                      color: Colors.grey,
                      splashColor: const Color(0xFF4A9EE8),
                      highlightColor: const Color(0xFF4A9EE8),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(height: 20),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.person),
                      color: Colors.grey,
                      splashColor: const Color(0xFF4A9EE8),
                      highlightColor: const Color(0xFF4A9EE8),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(height: 20),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.handyman_rounded),
                      color: Colors.grey,
                      splashColor: const Color(0xFF4A9EE8),
                      highlightColor: const Color(0xFF4A9EE8),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),

              const VerticalDivider(thickness: 1, color: Colors.grey),

              // ─── Contenu principal ───────────────────────────────────────
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // En-tête de page
                    Padding(
                      padding: const EdgeInsets.only(top: 5, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Accueil",
                            style: TextStyle(fontSize: 40, color: Colors.grey),
                          ),
                          SizedBox(height: 1),
                          Text(
                            "Tableau de bord",
                            style: TextStyle(fontSize: 10, color: Colors.blue),
                          ),
                        ],
                      ),
                    ),

                    const Divider(thickness: 1),
                    const SizedBox(height: 10),

                    // ─── Cartes statistiques ─────────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                // Carte repas servis
                                Container(
                                  height: 100,
                                  width: 120,
                                  color: Colors.red,
                                  child: const Center(
                                    child: Icon(
                                      Icons.coffee_outlined,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Container(
                                    height: 100,
                                    width: 500,
                                    color: Colors.white70,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: const [
                                        Text(
                                          "Nombre de repas servis : Données",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "Service en cours : Données",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w100,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          "Prix : Données",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w100,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 30),

                                // Carte QR code
                                Container(
                                  height: 100,
                                  width: 120,
                                  color: Colors.blue,
                                  child: const Center(
                                    child: Icon(
                                      Icons.qr_code_2,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Container(
                                    height: 100,
                                    width: 500,
                                    color: Colors.white70,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        OutlinedButton(
                                          style: ButtonStyle(
                                            foregroundColor:
                                                WidgetStateProperty.resolveWith<Color?>(
                                              (states) {
                                                if (states.contains(WidgetState.pressed)) {
                                                  return Colors.white;
                                                }
                                                return const Color(0xFF4A9EE8);
                                              },
                                            ),
                                            backgroundColor:
                                                WidgetStateProperty.resolveWith<Color?>(
                                              (states) {
                                                if (states.contains(WidgetState.pressed)) {
                                                  return const Color(0xFF4A9EE8);
                                                }
                                                return Colors.transparent;
                                              },
                                            ),
                                            side: WidgetStateProperty.all(
                                              const BorderSide(
                                                color: Color(0xFF4A9EE8),
                                                width: 1.5,
                                              ),
                                            ),
                                            shape: WidgetStatePropertyAll(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(3),
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            // Retournez vers le scanner avec GoRouter
                                            context.go("/scanner");
                                          },
                                          child: const Text("Lecture"),
                                        ),
                                        const SizedBox(height: 5),
                                        const Text(
                                          "Cliquez sur le bouton pour lire le code QR",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w100,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // ─── Carte : saisie du Code Pin / Token ──────────────
                    Card(
                      elevation: 11,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ExpansionTile(
                          initiallyExpanded: true,
                          tilePadding: EdgeInsets.zero,
                          childrenPadding: const EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                            bottom: 8.0,
                          ),
                          shape: const RoundedRectangleBorder(
                            side: BorderSide.none,
                          ),
                          collapsedShape: const RoundedRectangleBorder(
                            side: BorderSide.none,
                          ),
                          title: const Text(
                            "Entrez votre Code Pin ou le Token de Validation",
                            style: TextStyle(fontSize: 15),
                          ),
                          trailing: Icon(
                            isExpanded ? Icons.remove : Icons.add,
                            color: Colors.grey,
                          ),
                          onExpansionChanged: (value) {
                            setState(() {
                              isExpanded = value;
                            });
                          },
                          children: [
                            const ListTile(
                              title: Text("Code Pin ou le Token de Validation *"),
                            ),
                            const SizedBox(height: 3),
                            TextField(
                              controller: pinController,
                              obscureText: true,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              // TODO : ajouter un TextEditingController pour récupérer la valeur
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            OutlinedButton(
                              style: ButtonStyle(
                                foregroundColor:
                                    const WidgetStatePropertyAll(Colors.white),
                                backgroundColor: const WidgetStatePropertyAll(
                                  Color(0xFF4A9EE8),
                                ),
                                side: WidgetStateProperty.all(
                                  const BorderSide(
                                    color: Color(0xFF4A9EE8),
                                    width: 1.5,
                                  ),
                                ),
                                shape: WidgetStateProperty.resolveWith(
                                  (states) {
                                    if (states.contains(WidgetState.pressed)) {
                                      return RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3),
                                        side: const BorderSide(
                                          color: Colors.blue,
                                          width: 4,
                                        ),
                                      );
                                    }
                                    return RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    );
                                  },
                                ),
                              ),
                              onPressed: () {
                                // TODO : vérifier le token, valider le contenu
                                // du TextField, actualiser le compteur de repas servis
                              },
                              child: const Text("Valider"),
                            ),
                          ],
                        ),
                      ),
                    ), // ✅ Fermeture Card "Code Pin"

                    const SizedBox(height: 12),

                    // ─── Carte : 10 dernières personnes enregistrées ──────
                    Center(
                      child: Card(
                        elevation: 11,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Les 10 dernières personnes enregistrées",
                                ),
                              ),
                              // TODO : remplacer par une ListView quand les données sont disponibles
                              const Center(
                                child: Text(
                                  "Aucun étudiant trouvé",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ), // ✅ Fermeture Card "10 dernières personnes"

                  ],
                ),
              ), // ✅ Fermeture Expanded
            ],
          ); // ✅ Fermeture Row principale du body
        },
      ), // ✅ Fermeture LayoutBuilder

      // ─── Pied de page ────────────────────────────────────────────────────
      bottomNavigationBar: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            "© 2023 - 2026, Direction des Systèmes d'Informations (DSI)",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    ); // ✅ Fermeture Scaffold
  }
}