import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {

  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario(){
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  get getIdClient {
    return _prefs.getInt('idCliente');
  }

  set setIdClient(int value){
    _prefs.setInt('idCliente', value);
  }


  get getNameClient{
    return _prefs.getString('nameClient');
  }

  set setNameClient(String value){
    _prefs.setString('nameClient', value);
  }

   get getCorreoClient{
    return _prefs.getString('correoClient');
  }

  set setCorreoClient(String value){
    _prefs.setString('correoClient', value);
  } 

  get getPasswordClient{
    return _prefs.getString('passwordClient');
  }

  set setPasswordClient(String value){
    _prefs.setString('passwordClient', value);
  } 

}