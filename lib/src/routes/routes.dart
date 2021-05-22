import 'package:app_gustilandia/src/pages/about_app.dart';
import 'package:app_gustilandia/src/pages/edit_profile.dart';
import 'package:app_gustilandia/src/pages/example_page.dart';
import 'package:app_gustilandia/src/pages/login_page.dart';
import 'package:app_gustilandia/src/pages/my_orders.dart';
import 'package:flutter/material.dart';

import 'package:app_gustilandia/src/pages/tabs_page.dart';
import 'package:app_gustilandia/src/pages/tab_shop.dart';
import 'package:app_gustilandia/src/pages/tab_profile.dart';
import 'package:app_gustilandia/src/pages/tab_store.dart';
import 'package:app_gustilandia/src/pages/details_product.dart';

Map<String, WidgetBuilder> getAplicationRoutes(){
  return <String, WidgetBuilder>{
    'login'         : (BuildContext context) =>  LoginPage(),
    'tabs'          : (BuildContext context) => TabsPage(),
    'store'         : (BuildContext context) => TabStore(),
    'details'       : (BuildContext context) => DetailsProduct(),
    'shop'          : (BuildContext context) => TabShop(),
    'profile'       : (BuildContext context) => TabProfile(),

    'edit_profile'  : (BuildContext context) => EditProfile(),
    'bagShoping'    : (BuildContext context) => MyOrders(),
    'about'         : (BuildContext context) => AboutApp(),

    'exmaple'       :(BuildContext context) => ExamplePage(),
  };
}