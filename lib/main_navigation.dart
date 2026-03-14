import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/stats_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';
import 'theme_manager.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const StatsScreen(),
    const ProfileScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Re-build trigger
    bool isDark = ThemeManager.isDarkMode;

    return Scaffold(
      extendBody: true,
      body: _pages[_selectedIndex],
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 300), // Smooth color transition
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 25),
        height: 75,
        decoration: BoxDecoration(
          // AB YE COLOR CHANGE HOGA!
          color: isDark
              ? Colors.black.withOpacity(0.9)
              : Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(35),
          border: Border.all(
            color: isDark ? Colors.white12 : Colors.black12,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(isDark ? 0.2 : 0.1),
              blurRadius: 25,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_rounded, "Home", 0),
              _buildNavItem(Icons.bar_chart_rounded, "Stats", 1),
              _buildNavItem(Icons.person_rounded, "Profile", 2),
              _buildNavItem(Icons.settings_suggest_rounded, "Settings", 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    bool isDark = ThemeManager.isDarkMode;

    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              // Unselected icons
              color: isSelected
                  ? Colors.blueAccent
                  : (isDark ? Colors.grey : Colors.black45),
              size: isSelected ? 28 : 24,
            ),
            if (isSelected)
              Text(
                label,
                style: const TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}