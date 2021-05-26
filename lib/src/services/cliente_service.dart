import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:app_gustilandia/src/preferences/profile_preferences.dart';

final _URL_GUSTILANDIA = 'http://192.168.0.106:8085/backendgusti';

class ClienteService with ChangeNotifier{

  final _prefs = new PreferenciasUsuario();
  String messageError = "";

  Future<bool> registerClient(String name, String email, String password) async{

    final authData = {
      'nombreCompleto' : name,
      'idDocumentoIdentidad' : 1,
      'numeroDocumentoIdentidad' : password,
      'correo' : email, 
      "idDistrito": null,
      "celular": "",
      "direccion": "",
      "referencia": "",
      "idCliente": 0
    };

    final resp = await http.post(Uri.parse('$_URL_GUSTILANDIA/cliente'),
      headers: {'content-type': 'application/json'},
      body: json.encode(authData)
    );

    String body = utf8.decode(resp.bodyBytes);
    Map<String, dynamic> decodeResp = json.decode(body);

    if(decodeResp["result"] != null){

      final String nameRes = decodeResp["result"]["nombreCompleto"];
      final String correoRes = decodeResp["result"]["correo"];
      final String passwordRes = decodeResp["result"]["documentoIdentidad"]["documentoIdentidad"];

      saveInfoClient(nameRes, correoRes, passwordRes);
      notifyListeners();
      return true;
      
    }else{
      messageError = decodeResp["message"];
      return false;
    }
  

  }

  saveInfoClient(String name, String email, String password){

    _prefs.setNameClient = name;
    _prefs.setCorreoClient = email;
    _prefs.setPasswordClient = password;

  }

  


}