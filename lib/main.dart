import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_gustilandia/src/pages/tabs_page.dart';
import 'package:app_gustilandia/src/preferences/profile_preferences.dart';
import 'package:app_gustilandia/src/routes/routes.dart';
import 'package:app_gustilandia/src/services/cliente_service.dart';
import 'package:app_gustilandia/src/services/producto_service.dart';
import 'package:app_gustilandia/src/services/shop_service.dart';
import 'package:app_gustilandia/src/services/validation_signup.dart';
import 'package:app_gustilandia/src/theme/theme.dart';

void main() async{

  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.black,
  // ));

  WidgetsFlutterBinding.ensureInitialized();

  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(MyApp());
  
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ShopService(),),
        ChangeNotifierProvider(create: (_) => ProductoService(),),
        ChangeNotifierProvider(create: (_) => ClienteService(),),
        ChangeNotifierProvider(create: (_) => ValidationSignUpService(),)
      ],
      child: MaterialApp(
        theme: mytheme,
        debugShowCheckedModeBanner: false,
        // initialRoute: 'login',
        initialRoute: 'navigation',
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