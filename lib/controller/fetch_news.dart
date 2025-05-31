import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../model/newsArt.dart';

class FetchNews {
  static List sourcesId = [
    "abc-news", "bbc-news", "business-insider", "engadget", "espn",
    "financial-post", "fox-news", "google-news", "medical-news-today",
    "national-geographic", "news24", "new-scientist", "the-hindu",
    "techcrunch", "the-wall-street-journal", "usa-today"
  ];

  static Future<NewsArt> fetchNews() async {
    final _random = Random();
    String sourceID = sourcesId[_random.nextInt(sourcesId.length)];

    try {
      Response response = await get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=1d33742eb5604d12bcd6923ad142570f",
      ));

      if (response.statusCode == 200) {
        Map<String, dynamic> bodyData = jsonDecode(response.body);
        List articles = bodyData["articles"] ?? [];

        if (articles.isEmpty) throw Exception("No articles found");

        var myArticle = articles[_random.nextInt(articles.length)];
        return NewsArt.fromAPItoApp(myArticle);
      } else {
        throw Exception("Failed to fetch news: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching news: $e");
      throw Exception("Error fetching news");
    }
  }
}
