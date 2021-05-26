import 'package:flutter/material.dart';

bool isNumeric(String value){

  if(value.isEmpty) return false;

  final n = num.tryParse(value);

  return (n == null) ? false : true;

}


void mostrarAlerta(BuildContext context, String mensaje) {

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'Oh, al parecer hubo un error :C',
          style: TextStyle(
            color: Colors.yellow.shade800,
            fontWeight: FontWeight.bold
          ),
        ),
        content: Container(
          height: 150.0,
          decoration: BoxDecoration(
            color: Colors.yellow.shade200,
            borderRadius: BorderRadius.circular(5.0)
          ),
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.asset(
                "assets/images/warning.jpg",
                width: 70,
                height: 70,
              ),
              Text(
                '! $mensaje',
                maxLines: 2,
                style: TextStyle(
                  fontSize: 17.0,
                  color: Colors.yellow.shade800,
                  fontWeight: FontWeight.bold
                ),
              )
            ]
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'ok',
              style: TextStyle(
                color: Colors.yellow.shade800,
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      );
    }
  );

}