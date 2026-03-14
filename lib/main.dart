import 'package:flutter/material.dart';
import 'screens/splash_screen.dart'; // Splash screen import
import 'main_navigation.dart';    // Navigation controller import

void main() {
  runApp(const NexNews());
}

class NexNews extends StatelessWidget {
  const NexNews({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NexNews AI',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        primarySwatch: Colors.blue,
        // Text theme ko behtar karne ke liye
        fontFamily: 'Poppins',
      ),
      // App ab seedha Home par nahi, Splash Screen par khulegi
      home: const SplashScreen(),
    );
  }
}