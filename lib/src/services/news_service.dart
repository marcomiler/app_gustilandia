import 'dart:convert';

import 'package:app_gustilandia/src/model/category.model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app_gustilandia/src/model/news_models.dart';

final _URL_NEWS = 'https://newsapi.org/v2';
final _APIKEY   = 'a456f85d87e34ec1a63cf9b132408f80';

class NewsService with ChangeNotifier{

  List<Article> headlines = [];
  String _selectedCategory = 'business';

  bool _isLoading = true;
  
  List<Category> categories = [
    Category(FontAwesomeIcons.birthdayCake, 'business'),
    Category(FontAwesomeIcons.candyCane, 'entertainment'),
    Category(FontAwesomeIcons.hamburger, 'general'),
    Category(FontAwesomeIcons.cookie, 'health'),
    Category(FontAwesomeIcons.piedPiper, 'science'),
    Category(FontAwesomeIcons.gifts, 'sports'),
    Category(FontAwesomeIcons.cheese, 'technology'),
  ];

  Map<String, List<Article>> categoryArticle = {};

  NewsService(){

    this.getTopHeadlines();

    categories.forEach((item) {
      this.categoryArticle[item.name] = [];
    });

    this.getArticlesByCategory(this._selectedCategory);
  }

  bool get isLoading => this._isLoading;



  get selectedCategory => this._selectedCategory;

  set selectedCategory(String valor){
    this._selectedCategory = valor;

    this._isLoading = true;
    this.getArticlesByCategory(valor);
    notifyListeners();
  }

 getTopHeadlines() async{
    
    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=us';
    final resp = await http.get(Uri.parse(url));

    final newsResponse = newsResponseFromJson(resp.body);
    //print(newsResponse.articles[0].source.id);

    this.headlines.addAll(newsResponse.articles);
    notifyListeners();

  }

   List<Article> get getArticleCategorySelected => this.categoryArticle[this.selectedCategory];

 getArticlesByCategory(String category) async{

    if(this.categoryArticle[category].length > 0) {
      this._isLoading = false;
      notifyListeners();
      return this.categoryArticle[category];
    }

    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=us&category=$category';
    final resp = await http.get(Uri.parse(url));

    final newsResponse = newsResponseFromJson(resp.body);

    this.categoryArticle[category].addAll(newsResponse.articles);

    this._isLoading = false;
    notifyListeners();
  }

  Future <List<Article>> searchArticles(String query) async{

    //aqui falta mandarle el query para el search_delegate => Suggestion
    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=us';
    final resp = await http.get(Uri.parse(url));

    final decodedData = json.decode(resp.body);
    print(decodedData['articles']);

    final articles = new Articles.fromJsonList(decodedData['articles']);

    return articles.items;
  }
}

