import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../services/api_service.dart';
import '../models/news_model.dart';
import '../theme_manager.dart';
import '../widgets/ai_summarizer.dart';
import '../widgets/news_shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  final FlutterTts flutterTts = FlutterTts();

  String selectedCategory = "All";
  final TextEditingController _searchController = TextEditingController();
  final List<String> categories = ["All", "Technology", "Business", "Science", "Health", "Sports"];

  late Future<List<NewsArticle>> _newsFuture;

  @override
  void initState() {
    super.initState();
    _newsFuture = apiService.fetchNews();
  }

  void _updateCategory(String category) {
    setState(() {
      selectedCategory = category;
      _searchController.clear();
      _newsFuture = apiService.fetchNews(
          category: category == "All" ? "general" : category
      );
    });
  }

  void _onSearch(String query) {
    if (query.isNotEmpty) {
      setState(() {
        selectedCategory = "";
        _newsFuture = apiService.fetchNews(query: query);
      });
    }
  }

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.speak(text);
  }

  @override
  void dispose() {
    _searchController.dispose();
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeManager.bgColor,
      // RefreshIndicator
      body: RefreshIndicator(
        color: Colors.blueAccent,
        onRefresh: () async {
          _updateCategory(selectedCategory);
        },
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // --- FIXED: Dynamic Blue Gradient App Bar ---
            SliverAppBar(
              expandedHeight: 120.0,
              floating: true,
              pinned: true,
              elevation: 0,
              backgroundColor: ThemeManager.isDarkMode ? Colors.black : Colors.blueAccent,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: const Text('NexNews AI 🌐',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white, letterSpacing: 1.1)),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: ThemeManager.isDarkMode
                          ? [Colors.blueAccent.withOpacity(0.8), Colors.black]
                          : [Colors.blueAccent, Colors.lightBlue],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ),

            // --- Search & Category Section ---
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
                child: Column(
                  children: [
                    // Search Bar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: ThemeManager.cardColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withOpacity(0.05)),
                      ),
                      child: TextField(
                        controller: _searchController,
                        style: TextStyle(color: ThemeManager.textColor),
                        onSubmitted: _onSearch,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.search, color: Colors.blueAccent),
                          hintText: "Search AI insights...",
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Category Chips
                    SizedBox(
                      height: 45,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          bool isSelected = selectedCategory == categories[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: ChoiceChip(
                              label: Text(categories[index]),
                              selected: isSelected,
                              onSelected: (bool selected) => _updateCategory(categories[index]),
                              selectedColor: Colors.blueAccent,
                              backgroundColor: ThemeManager.cardColor,
                              labelStyle: TextStyle(
                                color: isSelected ? Colors.white : Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              elevation: 0,
                              side: BorderSide(color: isSelected ? Colors.blueAccent : Colors.white10),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --- News Feed Logic (Shimmer + Real Data) ---
            FutureBuilder<List<NewsArticle>>(
              future: _newsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Loading ke waqt Shimmer dikhayega
                  return const SliverToBoxAdapter(child: NewsShimmer());
                } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.wifi_off_rounded, size: 60, color: Colors.grey),
                          const SizedBox(height: 10),
                          Text("No News Found!", style: TextStyle(color: ThemeManager.textColor)),
                          TextButton(
                            onPressed: () => _updateCategory(selectedCategory),
                            child: const Text("Retry"),
                          )
                        ],
                      ),
                    ),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      var article = snapshot.data![index];
                      return _buildNewsCard(article, index);
                    },
                    childCount: snapshot.data!.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsCard(NewsArticle article, int index) {
    final String uniqueSeed = "${article.title.length}_$index";
    final String backupImageUrl = "https://picsum.photos/seed/$uniqueSeed/600/400";

    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 400 + (index * 100)),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: () => AiSummarizer.show(context, article.title),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: ThemeManager.cardColor,
            borderRadius: BorderRadius.circular(30),
            boxShadow: ThemeManager.isDarkMode
                ? []
                : [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 15, offset: const Offset(0, 8))],
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                child: Image.network(
                  (article.urlToImage.isNotEmpty && !article.urlToImage.contains("1504711434969"))
                      ? article.urlToImage
                      : backupImageUrl,
                  height: 200, width: double.infinity, fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Image.network(backupImageUrl, fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: ThemeManager.textColor),
                      maxLines: 2, overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text("AI Insight ✨",
                              style: TextStyle(color: Colors.blueAccent, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                        IconButton(
                          onPressed: () => _speak(article.title),
                          icon: const Icon(Icons.volume_up_rounded, color: Colors.blueAccent),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}