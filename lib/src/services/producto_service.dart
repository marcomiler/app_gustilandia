import 'dart:convert';

//import 'package:app_gustilandia/src/model/producto_model_temp.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app_gustilandia/src/model/category_temp_model.dart';
//import 'package:app_gustilandia/src/model/categoria_model.dart';
import 'package:app_gustilandia/src/model/producto_model.dart';

final _URL_GUSTILANDIA = 'http://192.168.0.106:8085/backendgusti';

class ProductoService with ChangeNotifier{

  List<Producto> productos = [];
  String _selectedCategory = 'galleta rellena';

  bool _islLoading = true;

  List<CategoryTempModel> categories = [
    CategoryTempModel(1,FontAwesomeIcons.cookie, 'galleta rellena',),
    CategoryTempModel(2,FontAwesomeIcons.breadSlice, 'snack',),
    CategoryTempModel(3,FontAwesomeIcons.stroopwafel, 'chocolate',),
    CategoryTempModel(4,FontAwesomeIcons.coffee, 'gaseosa',),
    CategoryTempModel(5,FontAwesomeIcons.bacon, 'Mani'),
    CategoryTempModel(6,FontAwesomeIcons.hamburger, 'papas'),
    CategoryTempModel(7,FontAwesomeIcons.candyCane, ' galleta con chocolate'),
    CategoryTempModel(8,FontAwesomeIcons.pizzaSlice, 'galleta salada'),
    CategoryTempModel(9,FontAwesomeIcons.iceCream, 'galleta dulce'),
    CategoryTempModel(10,FontAwesomeIcons.cheese, 'bizcocho dulce'),
  ];

  Map<String, List<Producto>> categoryProducto = {};

  ProductoService(){

    //this.getProducts();

    categories.forEach((item) {
      this.categoryProducto[item.name] = [];
    });
    this.getProductsByCategory(this._selectedCategory);
  }

  bool get isLoading => this._islLoading;

  get selectedCategory => this._selectedCategory;

  set selectedCategory(String valor){
    this._selectedCategory = valor;

    this._islLoading = true;
    this.getProductsByCategory(valor);
    notifyListeners();
  }

  // getProducts() async {

  //   final url = '$_URL_GUSTILANDIA/producto';
  //   final resp = await http.get(Uri.parse(url));

  //   final prodResponse = productoResponseFromJson(resp.body);

  //   this.productos.addAll(prodResponse.result);
  //   notifyListeners();

  // }

  List<Producto> get getProductsCategorySelected => this.categoryProducto[this.selectedCategory];

  getProductsByCategory(String categoria) async {

    if(this.categoryProducto[categoria].length > 0){
      this._islLoading = false;
      notifyListeners();
      return this.categoryProducto[categoria];
    }

    final categoriaFilter =  categories.where((element) => element.name == categoria).first;
    final id = categoriaFilter.id;

    final url = '$_URL_GUSTILANDIA/producto/listProductsByCategory/$id';
    final resp = await http.get(Uri.parse(url));
    
    final List<Producto> productos = [];
    //String body = utf8.decode(resp.bodyBytes);
    
    if(resp.statusCode == 200){
      final decodedData = json.decode(resp.body); 

      if(decodedData == null) return [];

      print(decodedData);

      for(var item in decodedData){
        productos.add(Producto.fromJson(item));
      }
    this.categoryProducto[categoria].addAll(productos);

    }
    this._islLoading = false;
    notifyListeners();
    }  
}