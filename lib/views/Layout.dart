import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restobadge/views/dashboard.dart';
import 'package:restobadge/views/Facturation.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => LayoutState();
}

class LayoutState extends State<Layout> {
  // Afficher les fenêtres contextuelles
  bool isMenuActive = false;
  bool isPersonActive = false;
  bool isSearchActive = false;
  bool isSettingsActive = false;
  bool isAvatarActive = false;

  //Page Active 
  Widget activePage = const Facturation();
  

  // Clé globale pour contrôler le Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //image 
  Widget image(double rayon) {
    return CircleAvatar(
      backgroundImage: const NetworkImage(""),
      radius: rayon,
      onBackgroundImageError: (_, _) {},
    );
  }

  // Widget du drawer
  Widget _buildDrawer() {
    return Drawer(
      width:  200 ,
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            
            // Titre du menu
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                "Menu de Navigation",
                style: TextStyle(fontSize: 13, color: Colors.grey),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            
            // Avatar
            if (isPersonActive) 
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: image(40),
              ),
            
            const SizedBox(height: 20),

            // Élément Tableau de bord
            _buildDrawerItem(
              icon: Icons.speed_sharp,
              label: "Tableau de bord",
              onTap: () {
                setState(() => activePage = const Dashboard());
                _scaffoldKey.currentState?.closeDrawer();
              },
            ),

            const SizedBox(height: 20),

            // Élément Facturation
            _buildDrawerItem(
              icon: Icons.handyman_rounded,
              label: "Facturation",
              onTap: () {
                setState(() => activePage = const Facturation());
                _scaffoldKey.currentState?.closeDrawer();
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget pour un élément du drawer
  Widget _buildDrawerItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start ,
          children: [
            Icon(icon, color: Colors.black87, size: 20),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A9EE8),
        titleSpacing: 0,
        leadingWidth: 800,
        
        title: isSearchActive ?  
        Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Saisir le texte ici pour rechercher ...",
                  hintStyle: const TextStyle(color: Colors.white60, fontSize: 13),
                  border: InputBorder.none, 
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.5),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                onChanged: (value) {
                  // TODO : logique de recherche
                },
              ), 
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () {
                setState(() {
                  isSearchActive = false;
                });
              },
            )  
          ],
        )
        : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/inphblogo.png',
                height: 40,
              ),
              const SizedBox(width: 15),

              // Bouton pour ouvrir/fermer le drawer
              IconButton(
                icon: const Icon(Icons.menu_rounded, size: 15),
                onPressed: () {
                  setState(() {
                    isMenuActive = !isMenuActive;
                  });
                  // Ouvre ou ferme le drawer
                  if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
                    _scaffoldKey.currentState?.closeDrawer();
                  } else {
                    _scaffoldKey.currentState?.openDrawer();
                  }
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
        
        actions: isSearchActive ? [] : [
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
            child: image(20)
          ),
          const SizedBox(width: 20),
        ],
      ),

      body: activePage,

      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
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
      ),
    );
  }
}