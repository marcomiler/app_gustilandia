import 'package:flutter/material.dart';
 
 
class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar Perfil',
          style: TextStyle(
            color: Colors.redAccent.shade200
          ),
        ),
      ),
      body: Container(),
    );
  }
}