import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            _crearFondo(context),
            _loginForm(context),
          ]
        ),
      ),
    );

  }
}

 Widget _loginForm(BuildContext context){

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
           padding: EdgeInsets.only(top: 40.0, bottom: 30.0, left: 20, right: 20),
           decoration: BoxDecoration(
             color: Colors.white,
             borderRadius: BorderRadius.circular(5.0),
             boxShadow: <BoxShadow>[
               BoxShadow(
                color: Colors.black26,
                blurRadius: 3.0,
                offset: Offset(0.0, 5.0),
                spreadRadius: 3.0
               )
             ]
           ),
          child: Column(
            children: <Widget>[
              Text('Ingreso', style: TextStyle(fontSize: 27.0, color: Colors.redAccent.shade100, fontWeight: FontWeight.bold)),
              SizedBox(height: 20.0,),
              _crearEmail(),
              SizedBox(height: 40.0,),
              _crearPassword(),
              SizedBox(height: 40.0,),
              _crearBoton(),
            ],
          ),
        ),

        TextButton(
          child: Text('Crear una nueva cuenta', style: TextStyle(color: Colors.white, fontSize: 17),),
           onPressed: (){} //=> Navigator.pushReplacementNamed(context, 'registro'),
        ),
        SizedBox(height: 40.0,),
       ],
     ),
   );
 }

  Widget _crearEmail(){
 
    return Container(
      child: TextField(
        cursorColor: Colors.redAccent.shade100,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.alternate_email, color: Colors.redAccent.shade100),
          hintText: 'ejemplo:correo.com',
          labelText: 'Correo electrónico',
          labelStyle: TextStyle(
            color: Colors.redAccent.shade200
          ),
          border: UnderlineInputBorder(
            borderSide: new BorderSide(color: Colors.redAccent.shade200)
          )
        ),
      ),
    );
  }  

  Widget _crearPassword(){

    return Container(
      child: TextField(
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          icon: Icon(Icons.lock_outline, color: Colors.redAccent.shade100),
          labelText: 'Contraseña',
        ),
      ),
    );
  } 

  Widget _crearBoton(){

    return ElevatedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: Text('Ingresar'),
      ),
      style: ButtonStyle(//las propiedades seran configuaradas con MaterialStateProperty
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)
        )),
      elevation: MaterialStateProperty.all(0.0),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      backgroundColor: MaterialStateProperty.all(Colors.redAccent.shade100)
    ),
    
      onPressed: (){}
  );
  }

  Widget _crearFondo(BuildContext context){

    final fondo = Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromRGBO(205, 92, 92, 0.7),
            Color.fromRGBO(255, 160, 122, 1.0)
          ]
        )
      ),
    );

    return Stack(
      children: <Widget>[
        fondo,
        Positioned(child: Container(child: _golosinas('assets/images/cake2.png')), top: 10, right: 5),
        Positioned(child: Container(child: _golosinas('assets/images/fresias.jpg')), top: 10, left: 5,),
        Positioned(child: Container(child: _golosinas('assets/images/cake1.jpg')), bottom: 10, left: 5,),
        Positioned(child: Container(child: _golosinas('assets/images/choco.png')), bottom: 10, right: 5,),

        Container(
          padding: EdgeInsets.only(top: 20.0, bottom: 2.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.storefront_sharp, color: Colors.white, size: 100.0),
              SizedBox(width: double.infinity,),
              Text('Gustilandia', style: TextStyle(color: Colors.white, fontSize: 35.0, fontWeight: FontWeight.bold))
            ]
          )
        )
      ],
    );
 }

 Widget _golosinas(String path) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(255, 255, 255, 0.8)
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.asset(
          path,
          fit: BoxFit.contain,
          width: 10,
          height: 10,
        ),
      ),
  );
}
      