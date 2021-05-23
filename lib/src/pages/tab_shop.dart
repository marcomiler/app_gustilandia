import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_gustilandia/src/model/producto_model.dart';
import 'package:app_gustilandia/src/services/producto_service.dart';

class TabShop extends StatelessWidget {

  TabShop();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 7,
          centerTitle: true,
          title: Text(
            'Carrito',
            style: TextStyle(
              color: Colors.redAccent.shade200,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: _FullCart(),
        // body: _FullCart(),
      ),
    );
  }
}

class _FullCart extends StatelessWidget {

   _FullCart();

  @override
  Widget build(BuildContext context) {

    final productoService = Provider.of<ProductoService>(context);

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: ListView.builder(
                itemExtent: 230,
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index){
                  final producto = productoService.searchProducts("");
                  return _ShoopingCartProduct(
                    producto: new Producto(),//enviar parametro de productos
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Card(
                elevation: 7,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(  
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                        Text('Sub total', style: TextStyle(color: Colors.black, fontSize: 15),),
                        Text('0.0 Soles', style: TextStyle(color: Colors.black, fontSize: 15)),
                        ]
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                        Text('Delivery', style: TextStyle(color: Colors.black, fontSize: 15),),
                        Text('Free', style: TextStyle(color: Colors.black, fontSize: 15)),
                        ]
                      ),  
                      SizedBox(height: 10.0,), 
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Total:', 
                            style: TextStyle(
                              color: Colors.black, 
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            'S/ 00.00',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                            )
                          ),
                        ]
                      ),
                      Spacer(),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.red,
                        ),
                        width: double.infinity,
                        height: 50,
                        child: InkWell(
                          child: Text(
                            'Finalizar compra',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 25,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onTap: (){},
                          
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ] ,
      ),
    );
  }
}

class _ShoopingCartProduct extends StatelessWidget {

  
  _ShoopingCartProduct({Key key, this.producto}) : super(key: key);

  final Producto producto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
        child: Stack(
          children: <Widget>[
          Card(
            color: Colors.white,
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            child: Padding( 
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: CircleAvatar(
                      backgroundColor: Colors.black26,
                      child: ClipOval(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Image.asset(
                            'assets/images/no-avatar.jpg',
                            fit: BoxFit.contain
                          ),
                        ),
                      ),
                    )
                  ),
                  SizedBox(height: 10.0,),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Contrary to popular belief, Lorem Ipsum',
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 10.0,),
                        Text(
                          'is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 10.0,),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.cyan,
                                  borderRadius: BorderRadius.circular(4)
                                ),
                                child: InkWell(
                                  child: Icon(Icons.remove, color: Colors.white,),
                                  onTap: (){},
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  '2',
                                  style: TextStyle(
                                    color: Colors.black
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(4)
                                ),
                                child: InkWell(
                                  child: Icon(Icons.add, color: Colors.white,),
                                  onTap: (){},
                                ),
                              ), 
                              Spacer(),
                              Text(
                                'S/ 00',
                                style: TextStyle(  
                                  color: Colors.blue,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ],  
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: InkWell(
              onTap: (){},
              child: CircleAvatar(
                backgroundColor: Colors.pink,
                child: Icon(Icons.delete_outline, color: Colors.white),
              ),
            )
          )
        ]
      ),
    );
  }
}


class _EmptyCart extends StatelessWidget {
   
   _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/carritoVacio.png',
            height: 120,
          ),
          SizedBox(height: 20,),
          Text(
            'No hay productos en el carrito',
            textAlign: TextAlign.center,
            style: TextStyle( 
              fontSize: 25.0,
              color: Colors.black54
            ),
          ),
          SizedBox(height: 20,),
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(5),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                )),
                backgroundColor: MaterialStateProperty.all(Colors.redAccent.shade100),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Ir a comprar',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              ),
              onPressed: (){
                Navigator.pushNamed(context, 'tabs');
              },
            ),  
          )
        ],
      ),
    );
  }
}