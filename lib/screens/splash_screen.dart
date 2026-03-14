import 'dart:async';
import 'package:flutter/material.dart';
import '../main_navigation.dart';
import 'dart:math' as math; // 3D rotation ke liye zaroori hai

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();

    // Controller for multi-animations
    _controller = AnimationController(
        duration: const Duration(seconds: 3),
        vsync: this
    )..repeat(reverse: true);

    // Subtle scaling effect
    _animation = Tween<double>(begin: 0.8, end: 1.1).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut)
    );

    // 3D Rotation effect logic
    _rotation = Tween<double>(begin: 0, end: 2 * math.pi).animate(
        CurvedAnimation(parent: _controller, curve: Curves.slowMiddle)
    );

    // Timer to navigate
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainNavigation())
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // --- Animated Background Gradient ---
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0F0F0F), Color(0xFF1A1A2E), Color(0xFF16213E)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // --- UI Content ---
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 3D Rotating & Pulsing Icon
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.002) // Perspective for 3D
                        ..rotateY(_rotation.value) // Horizontal 3D Flip
                        ..scale(_animation.value), // Pulsing
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.5),
                              blurRadius: 50,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        child: const Icon(
                            Icons.auto_awesome,
                            size: 100,
                            color: Colors.blueAccent
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 40),

                // Animated Text with Spacing
                TweenAnimationBuilder(
                  duration: const Duration(seconds: 2),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, double value, child) {
                    return Opacity(
                      opacity: value,
                      child: Padding(
                        padding: EdgeInsets.only(top: 20 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Text(
                        "NexNews AI",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 4,
                          shadows: [
                            Shadow(
                              color: Colors.blueAccent.withOpacity(0.8),
                              blurRadius: 15,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "INTELLIGENT NEWS AGGREGATOR",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Loading Indicator
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent.withOpacity(0.5)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}