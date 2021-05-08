import 'package:app_gustilandia/src/pages/tabs_page.dart';
import 'package:flutter/material.dart';

import 'package:app_gustilandia/src/pages/details_product.dart';
import 'package:app_gustilandia/src/pages/tab_home.dart';

Map<String, WidgetBuilder> getAplicationRoutes(){
  return <String, WidgetBuilder>{
    'tabs'    : (BuildContext context) => TabsPage(),
    'home'    : (BuildContext context) => TabHome(),
    'details' : (BuildContext context) => DetailsProduct(),


  };
}