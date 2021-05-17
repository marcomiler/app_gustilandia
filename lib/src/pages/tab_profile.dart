import 'package:flutter/material.dart';

import 'package:app_gustilandia/src/widget/list_perfil.dart';

class TabProfile extends StatelessWidget {
  TabProfile();

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
                      color: Color(0XFF4a503d)
                    ),
                    child: Padding( 
                      padding: EdgeInsets.all(4.0),
                      child: ClipRRect(
                        child: Image.asset('assets/images/no-avatar.jpg', fit: BoxFit.contain, width: 100, height: 100,),
                        borderRadius: BorderRadius.circular(50),
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
            SizedBox(height: 25.0),
            Expanded(
              flex: 2,
              child: ListPerfil(),
            )
          ],
        ),
      ),
    );
  }
}