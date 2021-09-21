import 'dart:convert';

import 'package:news_app/models/article_model.dart';
import 'package:http/http.dart';

class News{
  List<ArticleModel> news = [];
  Future<void> getNews() async {
    String url = 'http://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=a955f8b0f9d349998ff0b448d9ab3b76';
    var response =  await get(url);
    var data = await jsonDecode(response.body);
    if (data['status']=='ok'){
      data['articles'].forEach((element){
        if(element['urlToImage']!= null && element['description']!=null){
          ArticleModel articlemodel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
          );
          news.add(articlemodel);
        }

      });
    }
  }
}
class CategoryNews{
  List<ArticleModel> news = [];
  Future<void> getCategory(String category) async {
    String url = 'http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=a955f8b0f9d349998ff0b448d9ab3b76';
    var response =  await get(url);
    var data = await jsonDecode(response.body);
    if (data['status']=='ok'){
      data['articles'].forEach((element){
        if(element['urlToImage']!= null && element['description']!=null){
          ArticleModel articlemodel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
          );
          news.add(articlemodel);
        }

      });
    }
  }
}