import 'package:app_gustilandia/src/model/news_models.dart';
import 'package:app_gustilandia/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
 
class DetailsProduct extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

      final Article articulo = ModalRoute.of(context).settings.arguments;

      return SafeArea(
        child: Scaffold(
          backgroundColor: mytheme.backgroundColor,
          body: CustomScrollView(
            slivers: <Widget>[
              _crearAppBar(articulo),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    _details(),
                    SizedBox(height: 15,),
                  ]
                )
              ), 
            ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:  FloatingActionButton.extended(
          isExtended: true,
            hoverColor: Colors.red,
            icon: Icon(FontAwesomeIcons.shoppingCart, color: Colors.white,),
            elevation: 7,
            label: Text('Agregar al Carrito', style: TextStyle(color: Colors.white),),
            backgroundColor: Colors.redAccent,
            onPressed: (){},
        ),
          
      )
    );
  }
}

Widget _crearAppBar(Article article){

  return SliverAppBar(
    elevation: 2.0,
    backgroundColor: Colors.indigoAccent,
    expandedHeight: 300.0,
    floating: false,
    pinned: true,
    flexibleSpace: FlexibleSpaceBar(
      centerTitle: true,
      title: Text(
        'Aqui irá el titulo del producto',
        style: TextStyle(color: Colors.white, fontSize: 16.0)
      ),
      background: FadeInImage(
        placeholder: AssetImage('assets/images/loading.gif'),
        image: NetworkImage(article.getImageToUrl()),
        //fadeInDuration: Duration(milliseconds: 150),
        fit: BoxFit.cover,
        fadeInCurve: Curves.easeInToLinear,
      ),
    ),

  );

}

Widget _details() {

  final precio= 15;
  final lorem = 'It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.';
  return Container(
    margin: EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Acerca del producto: ',
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.black38,
              fontSize: 30.0,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10.0,),
        Text(
          lorem,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w300,
            color: Colors.grey
          ),
        ),
        Divider(),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[ 
            Text(
            'S/ $precio', 
              style: TextStyle(
                fontSize: 30, 
                color: Colors.red, 
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              'U. MED: CAJA',
              style: TextStyle(
                fontSize: 20, 
                color: Colors.black45, 
                fontWeight: FontWeight.normal
              ),
            ),
          ]
        ),
      SizedBox(height: 25.0,)
      ],
    ),
  );

}