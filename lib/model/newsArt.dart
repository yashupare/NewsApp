class NewsArt {
  String imgUrl;
  String newsHeading;
  String newsDescription;
  String newsContent;
  String newsUrl;

  NewsArt(
      {required this.imgUrl,
        required this.newsHeading,
        required this.newsDescription,
        required this.newsContent,
        required this.newsUrl
      });

  static NewsArt fromAPItoApp(Map<String, dynamic> article) {
    return NewsArt(
        imgUrl: article["urlToImage"] ?? "https://img.freepik.com/free-vector/breaking-news-concept_23-2148514216.jpg?w=2000",
        newsContent: article["content"] ?? "Breaking news! Check back later for full coverage.",
        newsDescription: article["description"] ?? "No description available at the moment.",
        newsHeading: article["title"]  ?? "Untitled News",
        newsUrl: article["url"] ?? "https://news.google.com/topstories?hl=en-IN&gl=IN&ceid=IN:en");
  }
}