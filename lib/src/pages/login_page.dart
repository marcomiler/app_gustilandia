import 'package:app_gustilandia/src/utils/my_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app_gustilandia/src/utils/utils.dart';
import 'package:app_gustilandia/src/services/cliente_service.dart';
import 'package:app_gustilandia/src/services/validation_signup.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> keyFormLogin = new GlobalKey();
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
          _crearFondo(context),
          _loginForm(context),
        ]),
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    //para poder scrollear a los que lo contengan
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 160.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.only(top: 20.0, bottom: 10),
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
              key: keyFormLogin,
              child: Column(
                children: <Widget>[
                  Text('Ingreso',
                      style: TextStyle(
                          fontSize: 27.0,
                          color: Colors.redAccent.shade100,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 20.0,
                  ),
                  _crearEmail(),
                  SizedBox(
                    height: 40.0,
                  ),
                  _crearPassword(),
                  SizedBox(
                    height: 40.0,
                  ),
                  _crearBoton(context),
                ],
              ),
            ),
          ),
          TextButton(
            child: Text(
              'Crear una nueva cuenta',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, 'register'),
          ),
          SizedBox(
            height: 40.0,
          ),
        ],
      ),
    );
  }

  void _login(BuildContext context) async {
    final clienteService = Provider.of<ClienteService>(context, listen: false);
    final validationService =
        Provider.of<ValidationSignUpService>(context, listen: false);
    ProgressDialog _progressDialog =
        MyProgressDialog.createProgressDialog(context, "Espere un momento...");

    if (!keyFormLogin.currentState.validate()) return;
    keyFormLogin.currentState.save();
    final email = validationService.email.value;
    final password = validationService.password.value;

    _progressDialog.show();
    bool login = await clienteService.loginCliente(email, password);
    _progressDialog.hide();
    if (!login) {
      _progressDialog.hide();
      mostrarAlerta(context, clienteService.messageError);
    } else {
      _progressDialog.hide();
      Navigator.pushReplacementNamed(context, 'navigation');
    }
  }

  Widget _crearEmail() {
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
            labelText: 'Correo electr??nico',
            errorText: validationService.email.error,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
            labelStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
            border: UnderlineInputBorder(
                borderSide: new BorderSide(color: Colors.redAccent.shade200))),
      ),
    );
  }

  Widget _crearPassword() {
    final validationService = Provider.of<ValidationSignUpService>(context);
    return Container(
      child: TextFormField(
        keyboardType: TextInputType.number,
        obscureText: _obscureText,
        onChanged: (String value) {
          validationService.changePassword(value);
        },
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
          labelText: 'Contrase??a',
          errorText: validationService.password.error,
          labelStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
        ),
      ),
    );
  }

  Widget _crearBoton(BuildContext context) {
    final validationService = Provider.of<ValidationSignUpService>(context);
    return ElevatedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: Text('Ingresar'),
      ),
      style: ButtonStyle(
          //las propiedades seran configuaradas con MaterialStateProperty
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
          elevation: MaterialStateProperty.all(0.0),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          backgroundColor:
              MaterialStateProperty.all(Colors.redAccent.shade100)),
      onPressed:
          (!validationService.isValidLogin) ? null : () => _login(context),
    );
  }

  Widget _crearFondo(BuildContext context) {
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
        // Positioned(child: Container(child: _golosinas('assets/images/cake2.png')), top: 10, right: 5),
        // Positioned(child: Container(child: _golosinas('assets/images/fresias.jpg')), top: 10, left: 5,),
        // Positioned(child: Container(child: _golosinas('assets/images/cake1.jpg')), bottom: 10, left: 5,),
        // Positioned(child: Container(child: _golosinas('assets/images/choco.png')), bottom: 10, right: 5,),

        Container(
            padding: EdgeInsets.only(top: 20.0, bottom: 2.0),
            child: Column(children: <Widget>[
              Icon(Icons.storefront_sharp, color: Colors.white, size: 100.0),
              SizedBox(
                width: double.infinity,
              ),
              Text('Gustilandia',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold))
            ]))
      ],
    );
  }

//  Widget _golosinas(String path) {
//     return Container(
//       width: 50,
//       height: 50,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: Color.fromRGBO(255, 255, 255, 0.8)
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(50),
//         child: Image.asset(
//           path,
//           fit: BoxFit.contain,
//           width: 10,
//           height: 10,
//         ),
//       ),
//   );
// }
}
