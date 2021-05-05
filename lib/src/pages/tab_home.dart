import 'package:app_gustilandia/src/services/news_service.dart';
import 'package:app_gustilandia/src/widget/list_news.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return Scaffold(
      body: ListNews(newsService.headlines),
    );
  }
}