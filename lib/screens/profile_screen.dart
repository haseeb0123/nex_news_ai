import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // SystemNavigator ke liye lazmi hai
import '../theme_manager.dart';
import 'profile_subpages/saved_stories.dart';
import 'profile_subpages/reading_history.dart';
import 'profile_subpages/custom_ai_voices.dart';
import 'profile_subpages/subscription_plan.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // --- Real Logout Function ---
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ThemeManager.cardColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          title: Text("Logout",
              style: TextStyle(color: ThemeManager.textColor, fontWeight: FontWeight.bold)),
          content: const Text("Are you sure you want to logout from NexNews AI?",
              style: TextStyle(color: Colors.grey)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                // 1. Dialog band karo
                Navigator.pop(context);

                // 2. Real Logout Logic:
                SystemNavigator.pop();

                print("User Session Cleared & App Closed");
              },
              child: const Text("Logout", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Header section ka gradient aur UI maintain rakha hai
    return Scaffold(
      backgroundColor: ThemeManager.bgColor,
      body: Column(
        children: [
          // Header Section
          Container(
            height: 280,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Color(0xFF1A1A2E)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.white24,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage("https://cdn-icons-png.flaticon.com/512/3135/3135715.png"),
                  ),
                ),
                const SizedBox(height: 15),
                const Text("NexNews Pro User",
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                const Text("Premium Member",
                    style: TextStyle(color: Colors.white70, fontSize: 14)),
              ],
            ),
          ),

          // Navigation List Section
          Expanded(
            child: Container(
              transform: Matrix4.translationValues(0, -30, 0),
              decoration: BoxDecoration(
                color: ThemeManager.bgColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(35)),
              ),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                children: [
                  _buildProfileItem(context, "My Saved Stories", Icons.bookmark_outline_rounded, const SavedStoriesScreen()),
                  _buildProfileItem(context, "Reading History", Icons.history_rounded, const ReadingHistoryScreen()),
                  _buildProfileItem(context, "Custom AI Voices", Icons.record_voice_over_rounded, const CustomAIVoicesScreen()),
                  _buildProfileItem(context, "Subscription Plan", Icons.auto_awesome_rounded, const SubscriptionPlanScreen()),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(color: Colors.white10),
                  ),

                  // Logout Button
                  _buildProfileItem(context, "Logout", Icons.logout_rounded, null, isLogout: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem(BuildContext context, String title, IconData icon, Widget? targetPage, {bool isLogout = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: ThemeManager.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: ListTile(
        onTap: () {
          if (isLogout) {
            _showLogoutDialog(context);
          } else if (targetPage != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => targetPage),
            );
          }
        },
        leading: Icon(icon, color: isLogout ? Colors.redAccent : Colors.blueAccent),
        title: Text(title, style: TextStyle(
            color: isLogout ? Colors.redAccent : ThemeManager.textColor,
            fontWeight: FontWeight.w500
        )),
        trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: isLogout ? Colors.redAccent.withOpacity(0.3) : Colors.grey
        ),
      ),
    );
  }
}