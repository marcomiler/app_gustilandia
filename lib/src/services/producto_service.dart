import 'dart:convert';

import 'package:app_gustilandia/src/preferences/profile_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app_gustilandia/src/model/category_temp_model.dart';
import 'package:app_gustilandia/src/model/producto_model.dart';

final _URL_GUSTILANDIA = 'http://192.168.0.106:8085/backendgusti';

class ProductoService with ChangeNotifier {
  String token = new PreferenciasUsuario().getToken;
  //List<Producto> productos = [];
  String _selectedCategory = 'galleta rellena';

  bool _islLoading = true;

  List<CategoryTempModel> categories = [
    CategoryTempModel(
      1,
      FontAwesomeIcons.cookie,
      'galleta rellena',
    ),
    CategoryTempModel(
      2,
      FontAwesomeIcons.breadSlice,
      'snack',
    ),
    CategoryTempModel(
      3,
      FontAwesomeIcons.stroopwafel,
      'chocolate',
    ),
    CategoryTempModel(
      4,
      FontAwesomeIcons.coffee,
      'gaseosa',
    ),
    CategoryTempModel(5, FontAwesomeIcons.bacon, 'Mani'),
    CategoryTempModel(6, FontAwesomeIcons.hamburger, 'papas'),
    CategoryTempModel(7, FontAwesomeIcons.candyCane, ' galleta con chocolate'),
    CategoryTempModel(8, FontAwesomeIcons.pizzaSlice, 'galleta salada'),
    CategoryTempModel(9, FontAwesomeIcons.iceCream, 'galleta dulce'),
    CategoryTempModel(10, FontAwesomeIcons.cheese, 'bizcocho dulce'),
  ];

  Map<String, List<Producto>> categoryProducto = {};

  ProductoService() {
    categories.forEach((item) {
      this.categoryProducto[item.name] = [];
    });
    this.getProductsByCategory(this._selectedCategory);
  }

  bool get isLoading => this._islLoading;

  get selectedCategory => this._selectedCategory;

  set selectedCategory(String valor) {
    this._selectedCategory = valor;

    this._islLoading = true;
    this.getProductsByCategory(valor);
    notifyListeners();
  }

  List<Producto> get getProductsCategorySelected =>
      this.categoryProducto[this.selectedCategory];

  List<Producto> _processList(http.Response resp) {
    final List<Producto> productos = [];
    if (resp.statusCode == 200) {
      String body = utf8.decode(resp.bodyBytes);
      final decodedData = json.decode(body);

      if (decodedData == null) return [];
      //print(decodedData);

      for (var item in decodedData) {
        productos.add(Producto.fromJson(item));
      }
    }
    return productos;
  }

  getProductsByCategory(String categoria) async {
    if (this.categoryProducto[categoria].length > 0) {
      this._islLoading = false;
      notifyListeners();
      return this.categoryProducto[categoria];
    }

    final categoriaFilter =
        categories.where((element) => element.name == categoria).first;
    final id = categoriaFilter.id;

    final url = '$_URL_GUSTILANDIA/producto/listProductsByCategory/$id';
    final resp = await http.get(Uri.parse(url),
        headers: {'content-type': 'application/json', 'Authorization': token});
    this.categoryProducto[categoria].addAll(_processList(resp));

    this._islLoading = false;
    notifyListeners();
  }

  Future<List<Producto>> searchProducts(String query) async {
    final url = '$_URL_GUSTILANDIA/producto/listProductsByName/$query';
    final resp = await http.get(Uri.parse(url),
        headers: {'content-type': 'application/json', 'Authorization': token});
    return _processList(resp);
  }
}
