import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app_gustilandia/src/pages/details_product.dart';
import 'package:app_gustilandia/src/model/producto_model.dart';
import 'package:app_gustilandia/src/services/producto_service.dart';

class DataSearch extends SearchDelegate{

  String selection;
  final productoService = new ProductoService();

  @override
  List<Widget> buildActions(BuildContext context) {
      // Acciones del AppBar
      return [
        IconButton(
          icon: Icon(FontAwesomeIcons.times, color: Colors.redAccent.shade100),
          onPressed: (){query = '' ;},
        )
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      // Icono para volver
      return IconButton(
        icon: Icon(
          FontAwesomeIcons.arrowLeft,
          color: Colors.redAccent.shade100
        ),
        onPressed: (){
          close(context, null);//retorna a la pantalla anterior y no devuelve nda en este caso
        }
      );
    }
  
    @override
    Widget buildResults(BuildContext context) {
      // Crea los resultados que vamos a mostrar
      return Center( 
        child: Container(
          height: 100.0,
          width: 100.0,
          color: Colors.deepOrange,
          child: Text(selection),  
        ),
      );
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
    // Sugerencias que apareceran cuando el usuario busque un producto

    if(query.isEmpty){return Container();}
    return FutureBuilder(
      // future: newsService.searchArticles(query),
      future: productoService.searchProducts(query),
      builder: (BuildContext context, AsyncSnapshot<List<Producto>> snapshot){
        if(snapshot.hasData){
          final productos = snapshot.data;
          return ListView(
            children: productos.map((producto) {
              producto.uniqueId = '${producto.idProducto}-search';
              return ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0)
                  ),
                  child: Hero(
                    tag: producto.uniqueId,
                    child: FadeInImage( 
                      fadeInDuration: Duration(milliseconds: 300),
                      fadeInCurve: Curves.easeInToLinear,
                      image: NetworkImage(producto.getImagen(producto.imagen)),
                      placeholder: AssetImage('assets/images/no-image.png'),
                      width: 50.0,
                      height: 80.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(producto.nameProduct, style: TextStyle(color: Colors.black),),
                subtitle: Text(producto.descripcion,style: TextStyle(color: Colors.black26), overflow: TextOverflow.ellipsis, maxLines: 1,),
                onTap: (){
                  close(context, null);//cierro la busqueda
                  producto.uniqueId = '';
                  Navigator.push(
                    context, 
                    PageRouteBuilder(
                      transitionDuration: Duration(seconds: 1),
                      pageBuilder: (_,__,___) => DetailsProduct(),
                      settings: RouteSettings(name: 'details', arguments: producto)
                    )
                  );
                  //Navigator.pushNamed(context, 'details', arguments: producto);
                },
              );
            }).toList(),
          );
        }else{
          return Center( 
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color> (Colors.red),
              strokeWidth: 5.0,
            ),
          );
        } 
      }
    );
  }

  @override
  String get searchFieldLabel => 'Buscar un producto';

  @override
  InputDecorationTheme get searchFieldDecorationTheme => InputDecorationTheme(
    hintStyle: TextStyle(color: Color(0XFF4a503d)),
    border: InputBorder.none,
    helperMaxLines: 1,
  );

}
