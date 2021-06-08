import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:app_gustilandia/src/preferences/profile_preferences.dart';

final _URL_GUSTILANDIA = 'http://192.168.0.106:8085/backendgusti';

class ClienteService with ChangeNotifier {
  final _prefs = new PreferenciasUsuario();
  String messageError = "";

  Future<bool> loginCliente(String email, String contrasenia) async {
    final authData = {'usuario': email, 'contrasenia': contrasenia};

    final resp = await http.post(Uri.parse('$_URL_GUSTILANDIA/auth/login'),
        headers: {'content-type': 'application/json'},
        body: json.encode(authData));

    String body = utf8.decode(resp.bodyBytes);
    Map<String, dynamic> decodeResp = json.decode(body);

    if (decodeResp["token"] != null) {
      final int idClient = decodeResp['id'];
      final String nameLogin = decodeResp['nombre'];
      final String correoLogin = decodeResp["usuario"];
      final String token = decodeResp["token"];

      saveInfoClient(
          id: idClient, name: nameLogin, email: correoLogin, token: token);
      notifyListeners();
      return true;
    } else {
      //messageError = decodeResp["message"];
      messageError = "El usuario y/o contraseña no son validos";
      return false;
    }
  }

  Future<bool> registerClient(
      String name, String email, String password) async {
    final authData = {
      'nombreCompleto': name,
      'idDocumentoIdentidad': 1,
      'numeroDocumentoIdentidad': password,
      'correo': email,
      "idDistrito": null,
      "celular": "",
      "direccion": "",
      "referencia": "",
      "idCliente": 0
    };

    final resp = await http.post(Uri.parse('$_URL_GUSTILANDIA/cliente'),
        headers: {'content-type': 'application/json'},
        body: json.encode(authData));

    String body = utf8.decode(resp.bodyBytes);
    Map<String, dynamic> decodeResp = json.decode(body);

    if (decodeResp["result"] != null) {
      final int idClient = decodeResp["result"]["idCliente"];
      final String nameRes = decodeResp["result"]["nombreCompleto"];
      final String correoRes = decodeResp["result"]["correo"];
      //final String passwordRes = decodeResp["result"]["documentoIdentidad"]["documentoIdentidad"];

      saveInfoClient(id: idClient, name: nameRes, email: correoRes);
      notifyListeners();
      return true;
    } else {
      messageError = decodeResp["message"];
      return false;
    }
  }

  saveInfoClient(
      {int id, String name, String email, /*String password,*/ String token}) {
    _prefs.setIdClient = id;
    _prefs.setNameClient = name;
    _prefs.setCorreoClient = email;
    //_prefs.setPasswordClient = password;
    if (token == null || token == "") {
      _prefs.setToken = "";
    } else {
      _prefs.setToken = token;
    }
  }

  logOut(BuildContext context) {
    _prefs.setIdClient = 0;
    _prefs.setNameClient = "";
    _prefs.setCorreoClient = "";
    //_prefs.setPasswordClient = "";
    _prefs.setToken = "";
  }
}
