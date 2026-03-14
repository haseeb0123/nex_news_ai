class NewsArticle {
  final String title;
  final String description;
  final String urlToImage;
  final String url;
  final String content;

  NewsArticle({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.url,
    required this.content,
  });

  // API se aane wale JSON data ko Flutter Object mein convert karne ke liye
  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? "No Title",
      description: json['description'] ?? "No Description available.",
      urlToImage: json['urlToImage'] ?? "https://via.placeholder.com/150",
      url: json['url'] ?? "",
      content: json['content'] ?? "",
    );
  }
}