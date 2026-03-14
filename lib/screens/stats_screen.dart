import 'package:flutter/material.dart';
import '../theme_manager.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeManager.isDarkMode;

    return Scaffold(
      backgroundColor: ThemeManager.bgColor,
      appBar: AppBar(
        title: Text("AI Analytics",
            style: TextStyle(fontWeight: FontWeight.w900, color: ThemeManager.textColor, letterSpacing: 1)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Top Animated Stats ---
            _buildPremiumHeader(),

            const SizedBox(height: 30),
            Text("Activity Trends",
                style: TextStyle(color: ThemeManager.textColor, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),

            // --- Modern Graph Design ---
            _buildModernChart(),

            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Milestones",
                    style: TextStyle(color: ThemeManager.textColor, fontSize: 18, fontWeight: FontWeight.bold)),
                Text("View All", style: TextStyle(color: Colors.blueAccent, fontSize: 12, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 15),

            // --- Glassmorphic Achievement Grid ---
            _buildAchievementTile("Early Bird", "Read 5 articles before 8 AM", Icons.wb_sunny_rounded, Colors.orange),
            _buildAchievementTile("AI Enthusiast", "Listened to 10+ AI narrations", Icons.bolt_rounded, Colors.blueAccent),
            _buildAchievementTile("Deep Learner", "Spent 5h+ on Tech news", Icons.psychology_rounded, Colors.purpleAccent),

            const SizedBox(height: 100), // Bottom space for Nav bar
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumHeader() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueAccent, Colors.blueAccent.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(35),
        boxShadow: [BoxShadow(color: Colors.blueAccent.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Weekly Progress", style: TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 5),
              const Text("42 Articles", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10)),
                child: const Text("+12% from last week", style: TextStyle(color: Colors.white, fontSize: 10)),
              )
            ],
          ),
          // Circular Progress Indicator
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 80, width: 80,
                child: CircularProgressIndicator(
                  value: 0.7,
                  strokeWidth: 8,
                  backgroundColor: Colors.white12,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              const Text("70%", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildModernChart() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ThemeManager.cardColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent.withOpacity(0.2), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.show_chart_rounded, size: 50, color: Colors.blueAccent.withOpacity(0.5)),
                const SizedBox(height: 10),
                const Text("Insights Generating...", style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementTile(String title, String desc, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: ThemeManager.cardColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
          child: Icon(icon, color: color, size: 24),
        ),
        title: Text(title, style: TextStyle(color: ThemeManager.textColor, fontWeight: FontWeight.bold)),
        subtitle: Text(desc, style: const TextStyle(color: Colors.grey, fontSize: 11)),
        trailing: const Icon(Icons.verified_rounded, color: Colors.blueAccent, size: 20),
      ),
    );
  }
}