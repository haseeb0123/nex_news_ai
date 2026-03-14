import 'package:flutter/material.dart';
import '../../theme_manager.dart';

class SavedStoriesScreen extends StatelessWidget {
  const SavedStoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeManager.isDarkMode;
    final String dynamicAiImageUrl = "https://images.unsplash.com/photo-1677442136019-21780ecad995?auto=format&fit=crop&q=80&w=400";

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F0F0F) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Saved Stories",
            style: TextStyle(color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          // Expanded use
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Bigger, more prominent icon
                    Container(
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.bookmark_border_rounded, size: 100, color: Colors.blueAccent),
                    ),
                    const SizedBox(height: 30),
                    Text("Your Library is Empty",
                        style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 22, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 15),
                    const Text(
                      "Save your favorite AI-powered news articles to read or listen to them later.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 15, height: 1.5),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        shape: StadiumBorder(),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        elevation: 5,
                        shadowColor: Colors.blueAccent.withOpacity(0.3),
                      ),
                      child: const Text("Explore Trending News", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Recommended Section
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1A1A1A) : Colors.grey[100],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Recommended for You",
                    style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                // Recommendation Card
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.black26 : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blueAccent.withOpacity(0.1)),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(dynamicAiImageUrl, width: 60, height: 60, fit: BoxFit.cover),
                    ),
                    title: Text("AI Future in 2026",
                        style: TextStyle(color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.bold, fontSize: 14)),
                    subtitle: const Text("3 min read", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    trailing: const Icon(Icons.add_circle_outline_rounded, color: Colors.blueAccent),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}