import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';

class ApiService {
  final String apiKey = "61121358251a40329b319c4cc1dde259";

  Future<List<NewsArticle>> fetchNews({String category = "general", String? query}) async {
    try {
      String url;

      if (query != null && query.isNotEmpty) {
        url = "https://newsapi.org/v2/everything?q=$query&apiKey=$apiKey";
      } else {
        url = "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=$apiKey";
      }

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);

        // Safety check: Agar 'articles' null ho toh khali list bhejien
        final List<dynamic> body = json['articles'] ?? [];

        return body.map((item) => NewsArticle.fromJson(item)).toList();
      } else {
        print("API Error: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Network Error: $e");
      return [];
    }
  }
}