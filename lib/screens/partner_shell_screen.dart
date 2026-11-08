import 'package:flutter/material.dart';
import '../core/theme/partner_theme.dart';
import 'partner_dashboard_screen.dart';
import 'partner_stores_screen.dart';
import 'partner_riders_screen.dart';
import 'partner_ai_screen.dart';

class PartnerShellScreen extends StatefulWidget {
  const PartnerShellScreen({super.key});

  @override
  State<PartnerShellScreen> createState() => _PartnerShellScreenState();
}

class _PartnerShellScreenState extends State<PartnerShellScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    PartnerDashboardScreen(),
    PartnerStoresScreen(),
    PartnerRidersScreen(),
    PartnerAiScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PartnerTheme.background,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (idx) => setState(() => _currentIndex = idx),
        backgroundColor: PartnerTheme.surface,
        indicatorColor: PartnerTheme.primaryGold.withValues(alpha: 0.2),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_rounded),
            selectedIcon: Icon(Icons.dashboard_rounded, color: PartnerTheme.primaryGold),
            label: 'Earnings',
          ),
          NavigationDestination(
            icon: Icon(Icons.storefront_rounded),
            selectedIcon: Icon(Icons.storefront_rounded, color: PartnerTheme.primaryGold),
            label: 'Stores',
          ),
          NavigationDestination(
            icon: Icon(Icons.two_wheeler_rounded),
            selectedIcon: Icon(Icons.two_wheeler_rounded, color: PartnerTheme.primaryGold),
            label: 'Fleet',
          ),
          NavigationDestination(
            icon: Icon(Icons.smart_toy_rounded),
            selectedIcon: Icon(Icons.smart_toy_rounded, color: PartnerTheme.primaryGold),
            label: 'Partner AI',
          ),
        ],
      ),
    );
  }
}
