import 'package:flutter/material.dart';
import '../../theme_manager.dart';

class SubscriptionPlanScreen extends StatelessWidget {
  const SubscriptionPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeManager.bgColor,
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(30),
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Colors.blueAccent, Color(0xFF1A1A2E)]),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.auto_awesome, color: Colors.amber, size: 60),
              const SizedBox(height: 20),
              const Text("NexNews Pro", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text("Unlimited AI Listening\nAd-Free Experience\nCustom AI Voices", textAlign: TextAlign.center, style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.blueAccent, shape: const StadiumBorder()),
                child: const Text("Already Pro User"),
              )
            ],
          ),
        ),
      ),
    );
  }
}