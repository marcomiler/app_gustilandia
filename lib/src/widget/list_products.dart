import 'package:flutter/material.dart';

import 'package:app_gustilandia/src/model/producto_model.dart';
import 'package:app_gustilandia/src/pages/details_product.dart';

class ListProducts extends StatelessWidget {

  final List<Producto> producto; 
  const ListProducts(this.producto);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 0.5,
        mainAxisSpacing: 0.5,
        childAspectRatio: 0.7
      ),
      itemCount: producto.length,
      itemBuilder: (BuildContext context, index){
        return _TarjetaTopBar(producto[index]);
      },
    );
  }
}


class _TarjetaTopBar extends StatelessWidget {

  final Producto producto;

  const _TarjetaTopBar(this.producto,);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(      
      onTap: (){
        // Navigator.pushNamed(context, 'details', arguments: producto);
        Navigator.push(
          context, 
          PageRouteBuilder(
            transitionDuration: Duration(seconds: 1),
            pageBuilder: (_,__,___) => DetailsProduct(),
            settings: RouteSettings(name: 'details', arguments: producto)
          )
        );
      },
      child: Container(
        height: 300.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5.0,
              spreadRadius: 2.0,
              offset: Offset(2.0, 5.0)
            )
          ]
        ),
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: Column(
            children: [
              _showImage(producto),
              SizedBox(height: 5.0,),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Text(
                  producto.nameProduct, 
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 5.0,),
                Text(
                  producto.descripcion, 
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 5.0,),
                _showPrice(producto),
                SizedBox(height: 5.0,),
                  ],
                ),
              )
              
            ],
          ),
        ),
    );
  }
}



Widget _showPrice(Producto producto){
  if(producto.precio != null){
      return Text(
      'S/ ${producto.precio.toStringAsFixed(2)}',
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
        color: Colors.blue
      ),
    );
  }else{
    return Text(
      'El precio no esta disponible',
      maxLines: 1,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 25,
        color: Colors.grey
      ),
    );
  }

}

Widget _showImage(Producto producto) {

  producto.uniqueId = '${producto.idProducto}-gusti';

  if(producto.imagen != null && producto.imagen != ''){ 
  return Hero(
    tag: producto.uniqueId,
    child: Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black12, blurRadius: 3.0, offset: Offset(0, 1.0))
        ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0)),
        child: FadeInImage(
          height: 130,
          width: double.infinity,
          image: new NetworkImage(producto.getImagen(producto.imagen)),
          placeholder: AssetImage('assets/images/giphy.gif'),
          fit: BoxFit.fill,
          fadeOutDuration: Duration(milliseconds: 300),
          fadeInCurve: Curves.easeInToLinear,
        ),
      ),
    ),
  );
  }else{
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0)),
        child: Image(
          width: double.infinity,
          height: 220,
          image: AssetImage('assets/images/no-image-available.png'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}