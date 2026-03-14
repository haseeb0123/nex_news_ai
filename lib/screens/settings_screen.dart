import 'package:flutter/material.dart';
import '../theme_manager.dart';
import 'language_screen.dart'; // Abhi jo file banayi

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = ThemeManager.isDarkMode;

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeManager.isDarkMode;

    return Scaffold(
      backgroundColor: ThemeManager.bgColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // --- Premium Glassmorphic Header ---
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: isDark ? Colors.black : Colors.blueAccent,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Gradient Background
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isDark
                            ? [const Color(0xFF000428), const Color(0xFF004e92)]
                            : [Colors.blueAccent, Colors.blue.shade300],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  // Content
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Hero(
                        tag: 'profile_pic',
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(color: Colors.white24, shape: BoxShape.circle),
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage("https://cdn-icons-png.flaticon.com/512/3135/3135715.png"),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text("NexNews Pro User", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                      const Text("Premium Member", style: TextStyle(color: Colors.white70, fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              transform: Matrix4.translationValues(0, -30, 0),
              decoration: BoxDecoration(
                color: ThemeManager.bgColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(35)),
              ),
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader("PREFERENCES"),

                  // Dark Mode
                  _buildCard(
                    child: ListTile(
                      leading: _buildIcon(Icons.dark_mode_rounded, Colors.purpleAccent),
                      title: Text("Dark Mode", style: TextStyle(color: ThemeManager.textColor, fontWeight: FontWeight.bold)),
                      subtitle: Text(isDarkMode ? "Stealth Mode On" : "Bright Mode On", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      trailing: Switch.adaptive(
                        value: isDarkMode,
                        activeColor: Colors.blueAccent,
                        onChanged: (value) {
                          setState(() {
                            isDarkMode = value;
                            ThemeManager.isDarkMode = value;
                          });
                        },
                      ),
                    ),
                  ),

                  // AI Speed
                  _buildCard(
                    child: _buildTile(context, Icons.speed_rounded, "AI Voice Speed", "1.2x Fast", Colors.orangeAccent),
                  ),

                  // News Language (Navigation added here)
                  _buildCard(
                    child: _buildTile(
                      context,
                      Icons.translate_rounded,
                      "News Language",
                      "English (US)",
                      Colors.greenAccent,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LanguageScreen())),
                    ),
                  ),

                  const SizedBox(height: 25),
                  _buildSectionHeader("APP INFORMATION"),

                  _buildCard(
                    child: Column(
                      children: [
                        _buildTile(context, Icons.shield_moon_rounded, "Privacy Policy", "Secure", Colors.blueAccent),
                        const Divider(height: 1, indent: 60, color: Colors.white10),
                        _buildTile(context, Icons.info_outline_rounded, "App Version", "v2.8.5", Colors.grey),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) => Padding(
    padding: const EdgeInsets.only(left: 10, bottom: 15),
    child: Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
  );

  Widget _buildCard({required Widget child}) => Container(
    margin: const EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(
      color: ThemeManager.cardColor,
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
      ],
    ),
    child: child,
  );

  Widget _buildIcon(IconData icon, Color color) => Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(15)),
    child: Icon(icon, color: color, size: 22),
  );

  Widget _buildTile(BuildContext context, IconData icon, String title, String val, Color color, {VoidCallback? onTap}) => ListTile(
    onTap: onTap,
    leading: _buildIcon(icon, color),
    title: Text(title, style: TextStyle(color: ThemeManager.textColor, fontWeight: FontWeight.w600)),
    trailing: Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(val, style: const TextStyle(color: Colors.grey, fontSize: 13)),
        const SizedBox(width: 5),
        const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
      ],
    ),
  );
}