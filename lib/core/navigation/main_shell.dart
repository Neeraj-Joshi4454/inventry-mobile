import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Bottom-nav shell for the five main tabs. Built with
/// [StatefulShellRoute.indexedStack] (see app_router.dart) so each tab
/// keeps its own navigation stack and scroll/filter state when switching
/// away and back — e.g. leaving the Inventory tab mid-scroll or mid-search
/// and returning to it exactly as it was, rather than a fresh list.
class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      // Flat bar with a hairline top border. NavigationBar applies the
      // bottom safe-area inset itself (gesture-nav devices), and as a
      // Scaffold bottomNavigationBar it never overlaps page content or FABs.
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Theme.of(context).colorScheme.outlineVariant)),
        ),
        child: _navigationBar(context),
      ),
    );
  }

  Widget _navigationBar(BuildContext context) {
    // Six destinations need ~60px each for labels like "Purchases". Below
    // 360px wide, show only the selected label so icons and text never
    // collide; every destination stays reachable and has a tooltip.
    final narrow = MediaQuery.sizeOf(context).width < 360;
    return NavigationBar(
      labelBehavior: narrow
          ? NavigationDestinationLabelBehavior.onlyShowSelected
          : NavigationDestinationLabelBehavior.alwaysShow,
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: (index) => navigationShell.goBranch(
        index,
        // Tapping the already-active tab pops it back to its root screen
        // instead of doing nothing — the conventional bottom-nav behavior.
        initialLocation: index == navigationShell.currentIndex,
      ),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.dashboard_outlined),
          selectedIcon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        NavigationDestination(
          icon: Icon(Icons.inventory_2_outlined),
          selectedIcon: Icon(Icons.inventory_2),
          label: 'Products',
        ),
        NavigationDestination(
          icon: Icon(Icons.warehouse_outlined),
          selectedIcon: Icon(Icons.warehouse),
          label: 'Inventory',
        ),
        NavigationDestination(
          icon: Icon(Icons.shopping_bag_outlined),
          selectedIcon: Icon(Icons.shopping_bag),
          label: 'Purchases',
        ),
        NavigationDestination(
          icon: Icon(Icons.point_of_sale_outlined),
          selectedIcon: Icon(Icons.point_of_sale),
          label: 'Sales',
        ),
        NavigationDestination(icon: Icon(Icons.more_horiz), selectedIcon: Icon(Icons.more_horiz), label: 'More'),
      ],
    );
  }
}
