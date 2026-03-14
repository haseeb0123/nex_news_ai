import 'package:flutter/material.dart';
import '../theme_manager.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> languages = [
      {"name": "English (US)", "flag": "🇺🇸", "code": "en"},
      {"name": "Urdu (Pakistan)", "flag": "🇵🇰", "code": "ur"},
      {"name": "Hindi (India)", "flag": "🇮🇳", "code": "hi"},
      {"name": "Arabic (UAE)", "flag": "🇦🇪", "code": "ar"},
      {"name": "Spanish (Spain)", "flag": "🇪🇸", "code": "es"},
      {"name": "French (France)", "flag": "🇫🇷", "code": "fr"},
    ];

    return Scaffold(
      backgroundColor: ThemeManager.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: ThemeManager.textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Select Language", style: TextStyle(color: ThemeManager.textColor, fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: languages.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: ThemeManager.cardColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              leading: Text(languages[index]['flag']!, style: const TextStyle(fontSize: 24)),
              title: Text(languages[index]['name']!,
                  style: TextStyle(color: ThemeManager.textColor, fontWeight: FontWeight.w500)),
              trailing: languages[index]['code'] == 'en'
                  ? const Icon(Icons.check_circle, color: Colors.blueAccent)
                  : null,
              onTap: () => Navigator.pop(context),
            ),
          );
        },
      ),
    );
  }
}