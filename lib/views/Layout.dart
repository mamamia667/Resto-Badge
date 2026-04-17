import 'package:flutter/material.dart';
import 'package:restobadge/views/dashboard.dart';
import 'package:restobadge/views/Facturation.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => LayoutState();
}

class LayoutState extends State<Layout> {
  bool isSearchActive = false;
  bool isAvatarActive = false;

  final TextEditingController searchController = TextEditingController();
  
  // Page par défaut
  Widget activePage = const Facturation();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Gestionnaire d'image avec fallback si l'URL est vide
  Widget image(double rayon) {
    return CircleAvatar(
      radius: rayon,
      backgroundColor: Colors.grey[300],
      backgroundImage: const NetworkImage("https://via.placeholder.com/150"), // Mets ton URL ici
      onBackgroundImageError: (_, __) => const Icon(Icons.person, color: Colors.white),
      //retirer quand j'ajoute l'image de la base de données ! 
      child: const Icon(
        Icons.person, 
        color: Colors.white,
        size: 20,
      )
    );
  }

  // --- Widget helper pour les éléments du Drawer ---
  Widget _drawerItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    const Color activeColor = Color(0xFF4A9EE8);
    const Color inactiveColor = Colors.black54;

    return ListTile(
      leading: Icon(
        icon,
        color: isActive ? activeColor : inactiveColor,
        size: 22,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          color: isActive ? activeColor : inactiveColor,
          fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
        ),
      ),
      onTap: onTap,
      dense: true,
      horizontalTitleGap: 0, // Aligne l'icône plus près du texte
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    );
  }

  // --- Widget du Drawer ---
  Widget _buildDrawer() {
    return Drawer(
      width: 230,
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            Center(child: image(40)),
            const SizedBox(height: 15),
            const Center(
              child: Text(
                "Menu de Navigation",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Divider(height: 1),
            const SizedBox(height: 10),

            // Item Tableau de bord
            _drawerItem(
              icon: Icons.speed_sharp,
              label: "Tableau de bord",
              isActive: activePage is Dashboard,
              onTap: () {
                setState(() => activePage = const Dashboard());
                Navigator.pop(context);
              },
            ),

            // Item Facturation
            _drawerItem(
              icon: Icons.handyman_rounded,
              label: "Facturation",
              isActive: activePage is Facturation,
              onTap: () {
                setState(() => activePage = const Facturation());
                Navigator.pop(context);
              },
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
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF4A9EE8),
        elevation: 0,
        titleSpacing: 0,
        title: isSearchActive 
          ? _buildSearchField() 
          : _buildStandardAppBarTitle(),
        actions: isSearchActive ? [] : [
          IconButton(
            icon: const Icon(Icons.search, size: 20, color: Colors.white),
            onPressed: () => setState(() => isSearchActive = true),
          ),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: () => setState(() => isAvatarActive = !isAvatarActive),
            child: image(18),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: activePage,
      ),
    );
  }

  // --- Helper pour le titre standard de l'AppBar ---
  Widget _buildStandardAppBarTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          // Ton Logo
          Container(
            height: 35,
            width: 35,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child:  Image.asset(
                    'assets/images/inphblogo.png',
                    height: 40,
                  ),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.menu_rounded, color: Colors.white, size: 24),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
        ],
      ),
    );
  }

  // --- Helper pour le champ de recherche dans l'AppBar ---
  Widget _buildSearchField() {
    return Row(
      children: [
        const SizedBox(width: 15),
        Expanded(
          child: TextField(
            controller: searchController,
            autofocus: true,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: const InputDecoration(
              hintText: "Rechercher...",
              hintStyle: TextStyle(color: Colors.white60, fontSize: 14),
              border: InputBorder.none,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => setState(() => isSearchActive = false),
        ),
      ],
    );
  }
}