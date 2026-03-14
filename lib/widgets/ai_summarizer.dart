import 'package:flutter/material.dart';
import '../theme_manager.dart';

class AiSummarizer {
  static void show(BuildContext context, String newsTitle) {
    final isDark = ThemeManager.isDarkMode;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54, // Piche ka background thora dark
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.65, // Thora height barha di
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(35)),
          boxShadow: [
            BoxShadow(color: Colors.blueAccent.withOpacity(0.1), blurRadius: 20, spreadRadius: 5)
          ],
        ),
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Drag Handle ---
            Center(
              child: Container(
                width: 40, height: 4,
                decoration: BoxDecoration(color: Colors.grey.withOpacity(0.3), borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 25),

            // --- AI Header with Pulse Effect ---
            Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Glow effect
                    Container(
                      width: 45, height: 45,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Icon(Icons.psychology_rounded, color: Colors.blueAccent, size: 32),
                  ],
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("NexNews AI Analysis",
                        style: TextStyle(color: ThemeManager.textColor, fontSize: 18, fontWeight: FontWeight.bold)),
                    const Text("Processing insights...", style: TextStyle(color: Colors.blueAccent, fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 25),

            // --- Refined News Title ---
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.05),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                "Topic: $newsTitle",
                style: TextStyle(color: ThemeManager.textColor.withOpacity(0.8), fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 30),

            // --- AI Points (Now with better spacing and icons) ---
            _buildAiPoint(Icons.auto_awesome_rounded, "Global Impact", "This event is reshaping industry standards for the upcoming 2026 fiscal year."),
            _buildAiPoint(Icons.bolt_rounded, "Rapid Adoption", "Market trends show a 45% increase in interest over the last 48 hours."),
            _buildAiPoint(Icons.insights_rounded, "Expert View", "Analysts suggest this could lead to a major shift in decentralized tech."),

            const Spacer(),

            // --- Premium Action Button ---
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(colors: [Colors.blueAccent, Colors.blue]),
              ),
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.check_circle_outline_rounded, color: Colors.white),
                label: const Text("Understand Insights", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildAiPoint(IconData icon, String label, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: Colors.blueAccent.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: Colors.blueAccent, size: 18),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: Colors.blueAccent, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                const SizedBox(height: 4),
                Text(text, style: TextStyle(color: ThemeManager.textColor, fontSize: 14, height: 1.4, fontWeight: FontWeight.w400)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}