import 'package:app_gustilandia/src/pages/tab_home.dart';
import 'package:app_gustilandia/src/pages/tabs_page.dart';
import 'package:app_gustilandia/src/routes/routes.dart';
import 'package:app_gustilandia/src/services/news_service.dart';
import 'package:app_gustilandia/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light
  ));

  runApp(MyApp());
  
}

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
        //home: TabsPage(),
        initialRoute: 'tabs',
        routes: getAplicationRoutes(),
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (BuildContext context) => TabsPage()
          );
        },
      ),
    );
  }

}