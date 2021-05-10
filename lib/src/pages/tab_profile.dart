import 'package:flutter/material.dart';

class TabProfile extends StatelessWidget {
  const TabProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 7,
          title: Text(
            'Mi Perfil', 
            style: TextStyle(
              color: Colors.redAccent.shade200,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  Container( 
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green
                    ),
                    child: Padding( 
                      padding: EdgeInsets.all(4.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 50,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Text(
                    'Username',
                    style: TextStyle( 
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: Colors.black
                    ),
                  )
                ],
              ) 
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.red
              )
            )
          ],
        ),
      ),
    );
  }
}