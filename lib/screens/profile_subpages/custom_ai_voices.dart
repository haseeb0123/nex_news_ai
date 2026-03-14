import 'package:flutter/material.dart';
import '../../theme_manager.dart';

class CustomAIVoicesScreen extends StatelessWidget {
  const CustomAIVoicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeManager.bgColor,
      appBar: AppBar(title: const Text("AI Voices"), backgroundColor: Colors.transparent, elevation: 0),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(20),
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        children: [
          _voiceCard("Nova", "Female", true),
          _voiceCard("Echo", "Male", false),
          _voiceCard("Alloy", "Neutral", false),
          _voiceCard("Shimmer", "Female", false),
        ],
      ),
    );
  }

  Widget _voiceCard(String name, String type, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.blueAccent : ThemeManager.cardColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.mic_rounded, color: isSelected ? Colors.white : Colors.blueAccent, size: 40),
          const SizedBox(height: 10),
          Text(name, style: TextStyle(color: isSelected ? Colors.white : ThemeManager.textColor, fontWeight: FontWeight.bold)),
          Text(type, style: TextStyle(color: isSelected ? Colors.white70 : Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}