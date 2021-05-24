import 'package:app_gustilandia/src/model/producto_model.dart';
import 'package:app_gustilandia/src/services/shop_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
 
class DetailsProduct extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

      final Producto producto  = ModalRoute.of(context).settings.arguments;
      final shopService = Provider.of<ShopService>(context);

      return SafeArea(
        child: Scaffold(
           backgroundColor: Color(0XFFF2F4F4),
          body: CustomScrollView(
            slivers: <Widget>[
              _crearAppBar(producto),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    _details(producto),
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
            onPressed: (){
              shopService.addProduct(producto);
              Navigator.pop(context);
            }
        ),
          
      )
    );
  }
}

Widget _crearAppBar(Producto producto){

  return SliverAppBar(
    iconTheme: IconThemeData(
      color: Colors.black //darle color a los iconos del sliveAppBar
    ),
    elevation: 7.0,
    backgroundColor: Colors.indigoAccent,
    expandedHeight: 250.0,//ver opcion de aumentar a 300
    floating: false,
    pinned: true,
    flexibleSpace: FlexibleSpaceBar(
      centerTitle: true,
      title: Text(
        producto.nameProduct,
        style: TextStyle(color: Colors.redAccent.shade200, fontSize: 16.0, fontWeight: FontWeight.bold)
      ),
      background: Hero(
        tag: producto.uniqueId,
        child: FadeInImage(
          placeholder: AssetImage('assets/images/loading.gif'),
          image: NetworkImage(producto.getImagen(producto.imagen)),
          //fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
          fadeInCurve: Curves.easeInToLinear,
        ),
      ),
    ),

  );

}

Widget _details(Producto producto) {
  
  return Container(
    margin: EdgeInsets.all(15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Acerca del producto: ',
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.black87,
              fontSize: 30.0,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10.0,),
        Text(
          producto.descripcion,
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w700,
            color: Colors.grey
          ),
        ),
        Divider(),
        SizedBox(height: 20,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[ 
              _showMarca(producto),
              SizedBox(height: 10,),
              _showUMedida(producto)
            ],
          ),
        ),
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[ 
            _showPrice(producto),
          ],
        ),
        SizedBox(height: 30),
      ],
    ),
  );
}

Widget _showMarca(Producto producto){
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
     Text(
      'Marca: ', 
        style: TextStyle(
          fontSize: 20, 
          color: Colors.black87, 
          fontWeight: FontWeight.bold
        ),
      ),
      Spacer(),
      Text(
        producto.nameMarca, 
          style: TextStyle(
            fontSize: 22, 
            color: Colors.black38, 
            fontWeight: FontWeight.bold
          ),
      ),
    ]
  );
}

Widget _showUMedida(Producto producto){

return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Text(
        'U. Medida: ',
        style: TextStyle(
          fontSize: 20, 
          color: Colors.black87, 
          fontWeight: FontWeight.bold
        ),
      ),
      Spacer(),
      Text(
        producto.unidadMedida,
        style: TextStyle(
          fontSize: 22, 
          color: Colors.black38, 
          fontWeight: FontWeight.bold
        ),
      ),
    ]
  );
}

Widget _showPrice(Producto producto){

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[ 
      Text(
      'S/ Precio: ', 
        style: TextStyle(
          fontSize: 25, 
          color: Colors.black87, 
          fontWeight: FontWeight.bold
        ),
      ),
      Text(
      'S/ ${producto.precio}', 
        style: TextStyle(
          fontSize: 30, 
          color: Colors.blue, 
          fontWeight: FontWeight.bold
        ),
      ),
    ]
  );
}