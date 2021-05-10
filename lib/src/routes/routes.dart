import 'package:flutter/material.dart';

import 'package:app_gustilandia/src/pages/tabs_page.dart';
import 'package:app_gustilandia/src/pages/tab_shop.dart';
import 'package:app_gustilandia/src/pages/tab_profile.dart';
import 'package:app_gustilandia/src/pages/tab_store.dart';
import 'package:app_gustilandia/src/pages/details_product.dart';

Map<String, WidgetBuilder> getAplicationRoutes(){
  return <String, WidgetBuilder>{
    'tabs'    : (BuildContext context) => TabsPage(),
    'store'    : (BuildContext context) => TabStore(),
    'details' : (BuildContext context) => DetailsProduct(),
    'shop' : (BuildContext context) => TabShop(),
    'prodile' : (BuildContext context) => TabProfile(),

  };
}