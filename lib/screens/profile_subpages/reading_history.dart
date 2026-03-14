import 'package:flutter/material.dart';
import '../../theme_manager.dart';

class ReadingHistoryScreen extends StatelessWidget {
  const ReadingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeManager.isDarkMode;
    final List<Color> accentColors = [Colors.blue, Colors.purple, Colors.orange, Colors.teal];

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F0F0F) : Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Reading Journey",
            style: TextStyle(color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: 10,
        itemBuilder: (context, index) {
          Color itemColor = accentColors[index % accentColors.length];

          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
              borderRadius: BorderRadius.circular(24),
              // Sublte Shadow for depth
              boxShadow: [
                BoxShadow(color: itemColor.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Stack(
                children: [
                  // --- Left Color Accent Line ---
                  Positioned(
                    left: 0, top: 0, bottom: 0,
                    child: Container(width: 6, color: itemColor),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 15, 15),
                    leading: Container(
                      width: 52, height: 52,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [itemColor.withOpacity(0.2), itemColor.withOpacity(0.05)],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text("N", style: TextStyle(color: itemColor, fontWeight: FontWeight.bold, fontSize: 22)),
                      ),
                    ),
                    title: Text("News History Item #$index",
                        style: TextStyle(color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          Icon(Icons.access_time_rounded, size: 14, color: itemColor),
                          const SizedBox(width: 5),
                          Text("2 hours ago", style: TextStyle(color: itemColor.withOpacity(0.8), fontSize: 12, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16, color: isDark ? Colors.white24 : Colors.black26),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}