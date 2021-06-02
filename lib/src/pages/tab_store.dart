import 'package:app_gustilandia/src/widget/list_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app_gustilandia/src/model/category_temp_model.dart';
import 'package:app_gustilandia/src/search/search_delegate.dart';
import 'package:app_gustilandia/src/services/producto_service.dart';

class TabStore extends StatefulWidget {

  @override
  _TabTabStoreState createState() => _TabTabStoreState();
}

class _TabTabStoreState extends State<TabStore> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {

    final prodService = Provider.of<ProductoService>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 7, 
          centerTitle: true,
          title:Text(
            'Productos',
            style: TextStyle(
              color: Colors.redAccent.shade200,
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.search, 
                color: Colors.redAccent.shade100,
                size: 20.0,
              ),
              onPressed: (){
                showSearch(
                  context: context,
                  delegate: DataSearch(),
                );
              }
            ),
          ],   
        ),
        body : Column(
            children: <Widget>[
            _ListaCategorias(),
            if(!prodService.isLoading)
              Expanded(
                child: ListProducts(prodService.getProductsCategorySelected)
              ),
            if(prodService.isLoading)
            Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color> (Colors.red),
                  strokeWidth: 6.0,
                )
              ),
            )
          ]
          ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ListaCategorias extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final prodService = Provider.of<ProductoService>(context);
    final categories = Provider.of<ProductoService>(context).categories;
    final _color = Colors.white38;

    return Container(
      decoration: BoxDecoration(
        color: _color,
      ),
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index){

          final cName = categories[index].name;

          return Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _CategoryButton(categories[index]),
                SizedBox(height: 5,),
                Text(
                  '${cName[0].toUpperCase()}${cName.substring(1)}',
                  style: TextStyle(
                    color: Colors.redAccent.shade200,
                    // fontWeight: newsService.selectedCategory == categories[index].name
                   fontWeight: prodService.selectedCategory == categories[index].name
                    ? FontWeight.bold
                    : FontWeight.normal
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget{

  final CategoryTempModel category;

  const _CategoryButton(this.category);

  @override
  Widget build(BuildContext context) {
    
    final prodService = Provider.of<ProductoService>(context);

    return GestureDetector(
      onTap: (){
        final prodService = Provider.of<ProductoService>(context, listen: false);
        prodService.selectedCategory = category.name;
      },
      child: Container(
        width: 40.0,
        height: 40.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (prodService.selectedCategory == this.category.name)
          ? Colors.redAccent.shade200
          : Colors.redAccent.shade100,
        ),
        child: Icon(
          category.icon,
          color: (prodService.selectedCategory == this.category.name)
          ? Colors.white
          : Colors.white60,
          size: (prodService.selectedCategory == this.category.name)
          ? 26
          : 18
        ),
      ),
    );
  }

}