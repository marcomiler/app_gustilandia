import 'package:app_gustilandia/src/model/news_models.dart';
import 'package:app_gustilandia/src/services/news_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      ),
    );
  }
}

class _FullCart extends StatelessWidget {

   _FullCart();

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

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
                itemCount: newsService.headlines.length,
                itemBuilder: (context, index){
                  final article = newsService.headlines[index];
                  return _ShoopingCartProduct(
                    article: article,
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
                            'S/ 85.00',
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

  
  _ShoopingCartProduct({Key key, this.article}) : super(key: key);

  final Article article;

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
                            fit: BoxFit.fill
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
                          article.title,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 10.0,),
                        Text(
                          article.description,
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
                                'S/ 15',
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