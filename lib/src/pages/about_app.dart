import 'package:flutter/material.dart';
 
 
class AboutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Acerca de Gustilandia',
          style: TextStyle(
            color: Colors.redAccent.shade200
          ),
        ),
      ),
      body: Container(),
    );
  }
}