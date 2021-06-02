import 'package:flutter/material.dart';

import 'package:app_gustilandia/src/model/producto_model.dart';

class ShopService with ChangeNotifier{

  List<ProductItem> itemsShop = <ProductItem>[];
  int totalItems = 0;
  int totalProducts = 0;
  double totalPriceProduct = 0.0;
  double totalPriceCart = 0.0;
  double igv = 0.0;
  double subtotal = 0.0;

  void addProduct(Producto prod){ 

    //final temp = List<ProductItem>.from(itemsShop);
    bool found = false;
    for(ProductItem p in itemsShop){
      if(p.product.nameProduct == prod.nameProduct){
        increment(p);
        found = true;
        break;
      }
    }
    if(!found){
      itemsShop.add(ProductItem(product: prod));
    }
    calculateTotals(itemsShop);
  }

  void calculateTotals(List<ProductItem> tempList){
    totalItems = tempList.fold(0, (previousValue, element) => element.quantity + previousValue);
    totalPriceCart = tempList.fold(0, (previousValue, element) => (element.quantity * element.product.precio) + previousValue);
    
    igv = totalPriceCart * 0.16;
    subtotal = totalPriceCart - igv;
    totalProducts = itemsShop.fold(0, (previousValue, element) => element.quantity + previousValue);
    
    notifyListeners();// ya que todos los metodos entran a este "metodo" solo se refresca aqui
  }  

  void increment(ProductItem productItem){
    productItem.quantity += 1;
    itemsShop = List<ProductItem>.from(itemsShop);
    calculateTotals(itemsShop);
  }

    void substract(ProductItem productItem){
      if(productItem.quantity > 1){
        productItem.quantity -= 1;
        itemsShop = List<ProductItem>.from(itemsShop);
        calculateTotals(itemsShop);
      }
    }

    void remove(ProductItem prod){
      itemsShop.remove(prod);
      calculateTotals(itemsShop);
    }

    void removeAll(){
      itemsShop.clear();
      calculateTotals(itemsShop);
    }
}

class ProductItem{

    int quantity;
    final Producto product;

    ProductItem({this.quantity = 1, @required this.product});

}