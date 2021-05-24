import 'package:app_gustilandia/src/services/shop_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabShop extends StatelessWidget {

  TabShop();

  @override
  Widget build(BuildContext context) {

    final shopService = Provider.of<ShopService>(context);

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
        body: shopService.itemsShop.length == 0 ? _EmptyCart() : _FullCart(),
      ),
    );
  }
}

class _FullCart extends StatelessWidget {

   _FullCart();

  @override
  Widget build(BuildContext context) {

    final shopService = Provider.of<ShopService>(context);

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
                itemCount: shopService.itemsShop.length,
                itemBuilder: (context, index){
                  final producto = shopService.itemsShop[index];
                  return _ShoopingCartProduct(
                    productItem: producto,
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
                        Text('S/ ${shopService.subtotal.toStringAsFixed(2)}', style: TextStyle(color: Colors.black, fontSize: 15)),
                        ]
                      ),
                      SizedBox(height: 8.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                        Text('Igv(16%)', style: TextStyle(color: Colors.black, fontSize: 15),),
                        SizedBox(height: 10.0,),
                        Text('S/ ${shopService.igv.toStringAsFixed(2)}', style: TextStyle(color: Colors.black, fontSize: 15)),
                        ]
                      ),  
                      SizedBox(height: 8.0,), 
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
                            'S/ ${shopService.totalPriceCart.toStringAsFixed(2)}',
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
                        child: 
                        InkWell(
                          child: Text(
                            'Finalizar compra',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 25,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onTap: (){
                            _finallizedShop(context);
                          },
                          
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

  
  _ShoopingCartProduct({Key key, this.productItem}) : super(key: key);

  final ProductItem productItem;

  @override
  Widget build(BuildContext context) {

    final shopService = Provider.of<ShopService>(context);

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
                      backgroundColor: Colors.red,
                      child: ClipOval(
                        child: FadeInImage(
                          height: 120.0,
                          width: 120.0,
                          image: new NetworkImage(productItem.product.getImagen(productItem.product.imagen)),
                          placeholder: AssetImage('assets/images/giphy.gif'),
                          fit: BoxFit.fill,
                          fadeOutDuration: Duration(milliseconds: 300),
                          fadeInCurve: Curves.easeInToLinear,
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
                          productItem.product.nameProduct,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 10.0,),
                        Text(
                          productItem.product.descripcion,
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
                                  onTap: () => shopService.substract(productItem),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  '${productItem.quantity}',
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
                                  onTap: () => shopService.increment(productItem),
                                ),
                              ), 
                              Spacer(),
                              Text(
                                'S/ ${(productItem.quantity * productItem.product.precio).toStringAsFixed(2)}',
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
              onTap: () => shopService.remove(productItem),
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

void _finallizedShop(BuildContext context){
  showDialog(
    context: context, 
    barrierDismissible: true,
    builder: (context){
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: Text("Completa los datos para finalizar tu compra"),
        scrollable: true,
        content: Column(
          mainAxisSize: MainAxisSize.min,//para q se adapte al contenido interno
          children: <Widget>[
            Text('Aquí se mostraran los campos a completar para finalizar la compraAquí se mostraran los campos a completar para finalizar la compraAquí se mostraran los campos a completar para finalizar la compraAquí se mostraran los campos a completar para finalizar la compraAquí se mostraran los campos a completar para finalizar la compraAquí se mostraran los campos a completar para finalizar la compraAquí se mostraran los campos a completar para finalizar la compraAquí se mostraran los campos a completar para finalizar la compraAquí se mostraran los campos a completar para finalizar la compraAquí se mostraran los campos a completar para finalizar la compraAquí se mostraran los campos a completar para finalizar la compraAquí se mostraran los campos a completar para finalizar la compra'),
            FlutterLogo(size: 100.0,)
          ]
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text('Ok'),
            onPressed: ()  => Navigator.of(context).pop(),
          )              
        ],
      );
    }
  );  
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