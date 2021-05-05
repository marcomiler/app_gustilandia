import 'package:app_gustilandia/src/pages/tabs_page.dart';
import 'package:app_gustilandia/src/services/news_service.dart';
import 'package:app_gustilandia/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsService(),)
      ],
      child: MaterialApp(
        title: 'Material App',
        theme: mytheme,
        debugShowCheckedModeBanner: false,
        home: TabsPage()
      ),
    );
  }

}