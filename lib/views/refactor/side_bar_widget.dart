import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SideBarWidget extends StatelessWidget {
  final bool isMenuActive;
  final bool isPersonActive;
  final Widget avatarWidget;
  final String? activeRoute;

  const SideBarWidget({
    super.key,
    required this.isMenuActive,
    required this.isPersonActive,
    required this.avatarWidget,
    this.activeRoute,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isMenuActive ? 150 : 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isMenuActive
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "Menu de Navigation",
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              : const SizedBox(height: 10),
          SizedBox(child: isPersonActive ? avatarWidget : null),
          const SizedBox(height: 20),
          _NavItem(
            icon: Icons.speed_sharp,
            label: "Tableau de bord",
            route: "/Dashboard",
            isMenuActive: isMenuActive,
            isActive: activeRoute == "/Dashboard",
          ),
          const SizedBox(height: 20),
          _NavItem(
            icon: Icons.handyman_rounded,
            label: "Facturation",
            route: "/",
            isMenuActive: isMenuActive,
            isActive: activeRoute == "/",
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;
  final bool isMenuActive;
  final bool isActive;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.route,
    required this.isMenuActive,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => context.go(route),
            icon: Icon(icon),
            style: ButtonStyle(
              iconColor: WidgetStateColor.resolveWith((states) {
                if (states.contains(WidgetState.pressed) || isActive) {
                  return const Color(0xFF4A9EE8);
                }
                return Colors.black;
              }),
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          if (isMenuActive)
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isActive ? const Color(0xFF4A9EE8) : Colors.grey,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }
}
