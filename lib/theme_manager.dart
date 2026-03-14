import 'package:flutter/material.dart';

class ThemeManager {
  static bool isDarkMode = true;

  static Color get bgColor => isDarkMode ? const Color(0xFF0F0F0F) : const Color(0xFFF2F2F7);
  static Color get cardColor => isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
  static Color get textColor => isDarkMode ? Colors.white : Colors.black87;
  static Color get subTextColor => isDarkMode ? Colors.white70 : Colors.black54;
}