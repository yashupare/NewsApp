import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inbrief/screens/home_first/models/show_categories.dart';


import '../models/slider_model.dart';

class ShowCategoryNews{
  List<ShowCategoryModel> categories = [];


  Future<void> getCategoriesNews(String category)async{
    String url = "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=1d33742eb5604d12bcd6923ad142570f";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == 'ok'){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"]!=null && element['description']!=null) {
          ShowCategoryModel categoryModel = ShowCategoryModel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],

          );
          categories.add(categoryModel);
        }
      });
    }
  }
}