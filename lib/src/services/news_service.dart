import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:app_gustilandia/src/model/news_models.dart';

final _URL_NEWS = 'https://newsapi.org/v2';
final _APIKEY   = 'a456f85d87e34ec1a63cf9b132408f80';

class NewsService with ChangeNotifier{

  List<Article> headlines = [];

  NewsService(){

    this.getTopHeadlines();

  }

  getTopHeadlines() async{
    
    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=us';
    final resp = await http.get(Uri.parse(url));

    final newsResponse = newsResponseFromJson(resp.body);
    //print(newsResponse.articles[0].source.id);

    this.headlines.addAll(newsResponse.articles);
    notifyListeners();

  }

}