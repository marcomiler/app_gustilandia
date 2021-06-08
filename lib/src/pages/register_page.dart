import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app_gustilandia/src/services/cliente_service.dart';
import 'package:app_gustilandia/src/services/validation_signup.dart';
import 'package:app_gustilandia/src/utils/utils.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> keyForm = new GlobalKey();
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: <Widget>[
          _createFondo(context),
          _registerForm(context),
        ]),
      ),
    );
  }

  Widget _registerForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 10),
            padding:
                EdgeInsets.only(top: 40.0, bottom: 30.0, left: 20, right: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Form(
              key: keyForm,
              child: Column(
                children: <Widget>[
                  Text('Registro',
                      style: TextStyle(
                          fontSize: 27.0,
                          color: Colors.redAccent.shade100,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 20.0,
                  ),
                  _createFullName(context),
                  SizedBox(
                    height: 20.0,
                  ),
                  _createEmail(context),
                  SizedBox(
                    height: 30.0,
                  ),
                  _createPassword(context),
                  SizedBox(
                    height: 30.0,
                  ),
                  _createTextInfo(),
                  SizedBox(
                    height: 30.0,
                  ),
                  _createBoton(context),
                ],
              ),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton(
              child: Text(
                '¿Ya tienes una cuenta? Ingresar',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
            ),
          ]),
          SizedBox(
            height: 40.0,
          ),
        ],
      ),
    );
  }

  void _register(BuildContext context) async {
    final clienteService = Provider.of<ClienteService>(context, listen: false);
    final validationService =
        Provider.of<ValidationSignUpService>(context, listen: false);

    if (!keyForm.currentState.validate()) return;

    keyForm.currentState.save();
    final name = validationService.nombreCompleto.value;
    final email = validationService.email.value;
    final password = validationService.password.value;

    bool register = await clienteService.registerClient(name, email, password);

    if (!register) {
      mostrarAlerta(context, clienteService.messageError);
    } else {
      Navigator.pushReplacementNamed(context, 'navigation');
    }
  }

  Widget _createTextInfo() {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.yellowAccent.shade700,
      ),
      child: Text(
        'Atención: Su contraseña será su número de DNI, por favor ingrese el formato correcto. \n Ej: 71727172',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _createFullName(BuildContext context) {
    final validationService = Provider.of<ValidationSignUpService>(context);

    return Container(
      child: TextFormField(
        cursorColor: Colors.redAccent.shade100,
        keyboardType: TextInputType.emailAddress,
        onChanged: (String value) {
          validationService.changeNombreCompleto(value);
        },
        decoration: InputDecoration(
          icon:
              Icon(FontAwesomeIcons.userAlt, color: Colors.redAccent.shade100),
          hintText: 'Ej: Juan Perez Carrasco',
          labelText: 'Escriba su nombre completo',
          errorText: validationService.nombreCompleto.error,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
          labelStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
          border: UnderlineInputBorder(
              borderSide: new BorderSide(color: Colors.redAccent.shade200)),
        ),
      ),
    );
  }

  Widget _createEmail(BuildContext context) {
    final validationService = Provider.of<ValidationSignUpService>(context);

    return Container(
      child: TextFormField(
        cursorColor: Colors.redAccent.shade100,
        keyboardType: TextInputType.emailAddress,
        onChanged: (String value) {
          validationService.changeEmail(value);
        },
        decoration: InputDecoration(
            icon: Icon(FontAwesomeIcons.at, color: Colors.redAccent.shade100),
            hintText: 'Ej: ejemplo@ejemplo.com',
            labelText: 'Correo electrónico',
            errorText: validationService.email.error,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
            labelStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
            border: UnderlineInputBorder(
                borderSide: new BorderSide(color: Colors.redAccent.shade200))),
      ),
    );
  }

  Widget _createPassword(BuildContext context) {
    final validationService = Provider.of<ValidationSignUpService>(context);

    return Container(
      child: TextFormField(
        keyboardType: TextInputType.number,
        onChanged: (String value) {
          validationService.changePassword(value);
        },
        obscureText: _obscureText,
        decoration: InputDecoration(
          suffixIcon: Padding(
            padding: EdgeInsetsDirectional.only(start: 12),
            child: IconButton(
              icon: Icon(Icons.remove_red_eye,
                  color:
                      _obscureText ? Colors.grey : Colors.redAccent.shade100),
              onPressed: _toggle,
            ),
          ),
          icon: Icon(FontAwesomeIcons.lock, color: Colors.redAccent.shade100),
          labelText: 'Contraseña',
          errorText: validationService.password.error,
          labelStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
        ),
      ),
    );
  }

  Widget _createBoton(BuildContext context) {
    final validationService = Provider.of<ValidationSignUpService>(context);

    return ElevatedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: Text('Registrar'),
      ),
      style: ButtonStyle(
          //las propiedades seran configuaradas con MaterialStateProperty
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
          elevation: MaterialStateProperty.all(0.0),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          backgroundColor:
              MaterialStateProperty.all(Colors.redAccent.shade100)),
      onPressed: (!validationService.isValid) ? null : () => _register(context),
    );
  }

  Widget _createFondo(BuildContext context) {
    final fondo = Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(205, 92, 92, 0.7),
        Color.fromRGBO(255, 160, 122, 1.0)
      ])),
    );

    return Stack(
      children: <Widget>[
        fondo,
      ],
    );
  }
}
