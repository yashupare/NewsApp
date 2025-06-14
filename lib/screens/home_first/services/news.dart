import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inbrief/screens/home_first/models/article_model.dart';

class News{
  List<ArticleModel> news = [];


  Future<void> getNews()async{
    String url = "https://newsapi.org/v2/everything?q=tesla&from=2025-03-01&sortBy=publishedAt&apiKey=1d33742eb5604d12bcd6923ad142570f";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == 'ok'){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"]!=null && element['description']!=null) {
          ArticleModel articleModel = ArticleModel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],

          );
          news.add(articleModel);
        }
      });
    }
  }
}