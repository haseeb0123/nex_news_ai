import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../theme_manager.dart';

class NewsShimmer extends StatelessWidget {
  const NewsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeManager.isDarkMode;
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Shimmer.fromColors(
            baseColor: isDark ? Colors.grey[900]! : Colors.grey[300]!,
            highlightColor: isDark ? Colors.grey[800]! : Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                ),
                const SizedBox(height: 15),
                Container(height: 20, width: double.infinity, color: Colors.white),
                const SizedBox(height: 10),
                Container(height: 15, width: 150, color: Colors.white),
              ],
            ),
          ),
        );
      },
    );
  }
}