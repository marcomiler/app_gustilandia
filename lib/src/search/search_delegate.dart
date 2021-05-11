import 'package:app_gustilandia/src/model/news_models.dart';
import 'package:app_gustilandia/src/services/news_service.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate{

  String selection;
  final newsService = new NewsService();

  @override
  List<Widget> buildActions(BuildContext context) {
      // Acciones del AppBar
      return [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: (){query = '' ;},
        )
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      // Icono para volver
      return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
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
    // TSugerencias que apareceran cuando el usuario busque un producto

    if(query.isEmpty){return Container();}
    return FutureBuilder(
      future: newsService.searchArticles(query),
      builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot){
        if(snapshot.hasData){
          final articles = snapshot.data;
          return ListView(
            children: articles.map((article) {
              return ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0)
                  ),
                  child: FadeInImage( 
                    fadeInDuration: Duration(milliseconds: 300),
                    fadeInCurve: Curves.easeInToLinear,
                    image: NetworkImage(article.getImageToUrl()),
                    placeholder: AssetImage('assets/images/no-image.jpg'),
                    width: 50.0,
                    height: 80.0,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text('aqui va el titulo de la pelicula', style: TextStyle(color: Colors.black),),
                subtitle: Text('Aqui va el subtiulo',style: TextStyle(color: Colors.black26),),
                onTap: (){
                  close(context, null);//cierro la busqueda
                  article.uniqueId = '';
                  Navigator.pushNamed(context, 'details', arguments: article);
                },
              );
            }).toList(),
          );
        }else{
          return Center( 
            child: CircularProgressIndicator(),
          );
        } 
      }
    );
  }

}
