import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_gustilandia/src/services/cliente_service.dart';

bool isNumeric(String value) {
  if (value.isEmpty) return false;

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
            'Oh, al parecer hubo un problema :c',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.red, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          content: Container(
            height: 200.0,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
            padding: EdgeInsets.all(5),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset(
                    "assets/images/warning.jpg",
                    width: 80,
                    height: 80,
                  ),
                  Text(
                    '! $mensaje',
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  _buttonAlert(context, "Aceptar", Colors.yellowAccent.shade700,
                      Colors.white, () => Navigator.pop(context)),
                ]),
          ),
        );
      });
}

void alertLogOut(BuildContext context, String mensaje) {
  final clientService = Provider.of<ClienteService>(context, listen: false);

  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 180.0,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
            padding: EdgeInsets.all(5),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    mensaje,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  _buttonAlert(context, "Aceptar", Colors.white, Colors.blue,
                      () {
                    clientService.logOut(context);
                    Navigator.pushReplacementNamed(context, 'login');
                  }),
                  SizedBox(
                    height: 5.0,
                  ),
                  _buttonAlert(context, "Cancelar", Colors.red, Colors.white,
                      () => Navigator.pop(context)),
                ]),
          ),
        );
      });
}

Widget _buttonAlert(BuildContext context, String text, Color bgColorBtn,
    Color colorTextBtn, VoidCallback callback) {
  return ElevatedButton(
    child: Container(
      padding: EdgeInsets.all(15),
      child: Text(
        text,
        style: TextStyle(fontSize: 20),
      ),
    ),
    style: ButtonStyle(
      //las propiedades seran configuaradas con MaterialStateProperty
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      backgroundColor: MaterialStateProperty.all(bgColorBtn),
      foregroundColor: MaterialStateProperty.all(colorTextBtn),
    ),
    onPressed: callback,
  );
}

void showHelpCvv(BuildContext context) {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(15, 15, 15, 0),
        content: Container(
          height: 300,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
          //padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'El código de seguridad o CVV son tres dígitos de los siete que aparecen en el reverso de la tarjeta. \n \n Imagen de referencia:',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              Image.asset(
                "assets/images/cvv3.jpg",
                width: 150,
                height: 150,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text(
                      'Ok',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}

void showSnackBar(BuildContext context) {
  final snackbar = SnackBar(
    content: Text("El producto se agregó al carrito"),
    duration: Duration(milliseconds: 1500),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50))),
    margin: EdgeInsets.symmetric(vertical: 50), //opcional
    elevation: 7,
    behavior: SnackBarBehavior.floating,
  );

  displaySnackBar(context: context, snackbar: snackbar);
}

void displaySnackBar({@required BuildContext context, SnackBar snackbar}) {
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
