import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:app_gustilandia/src/model/cliente_model.dart';
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
      final int idClient = decodeResp["result"]['id'];
      final String nameRes = decodeResp["result"]['nombre'];
      final String correoRes = decodeResp["result"]["usuario"];
      final String token = decodeResp["result"]["token"];

      //final String passwordRes = decodeResp["result"]["documentoIdentidad"]["documentoIdentidad"];
      print(decodeResp["result"]);
      saveInfoClient(
          id: idClient, name: nameRes, email: correoRes, token: token);
      notifyListeners();
      return true;
    } else {
      messageError = decodeResp["message"];
      return false;
    }
  }

  //Editar Datos del Cliente
  Future<bool> editClient(String phone, String email, String direction,
      int idDistrito, String fullName, String dni, String reference) async {
    final authData = {
      'nombreCompleto': fullName,
      'idDocumentoIdentidad': 1,
      'numeroDocumentoIdentidad': dni,
      'correo': email,
      "idDistrito": idDistrito,
      "celular": phone,
      "direccion": direction,
      "referencia": reference,
      "idCliente": _prefs.getIdClient
    };

    final resp = await http.put(Uri.parse('$_URL_GUSTILANDIA/cliente'),
        headers: {
          'content-type': 'application/json',
          'Authorization': _prefs.getToken
        },
        body: json.encode(authData));

    String body = utf8.decode(resp.bodyBytes);
    Map<String, dynamic> decodeResp = json.decode(body);

    if (decodeResp["result"] != null) {
      print(decodeResp["result"]);
      final int idClient = decodeResp["result"]['idCliente'];
      final String nameRes = decodeResp["result"]['nombreCompleto'];
      final String correoRes = decodeResp["result"]["correo"];

      print(decodeResp["result"]);
      saveInfoClient(id: idClient, name: nameRes, email: correoRes);
      notifyListeners();
      return true;
    } else {
      messageError = decodeResp["message"];
      return false;
    }
  }

  //Editar Distrito del Cliente
  Future<bool> editDirectionClient(
      int idDistrict, String direction, String reference) async {
    final authData = {
      'idDistrito': idDistrict,
      'direccion': direction,
      'referencia': reference,
    };

    final resp = await http.put(
        Uri.parse('$_URL_GUSTILANDIA/cliente/direccion'),
        headers: {
          'content-type': 'application/json',
          'Authorization': _prefs.getToken
        },
        body: json.encode(authData));

    String body = utf8.decode(resp.bodyBytes);
    Map<String, dynamic> decodeResp = json.decode(body);
    print(decodeResp);

    if (decodeResp["success"] != false) {
      print(decodeResp["result"]);
      notifyListeners();
      return true;
    } else {
      messageError = decodeResp["message"];
      return false;
    }
  }

  Future<List<Cliente>> getClientById(int id) async {
    final List<Cliente> clientes = [];
    final url = '$_URL_GUSTILANDIA/cliente/$id';
    final resp = await http.get(Uri.parse(url), headers: {
      'content-type': 'application/json',
      'Authorization': _prefs.getToken
    });
    if (resp.statusCode == 200) {
      String body = utf8.decode(resp.bodyBytes);
      final decodedData = json.decode(body);
      if (decodedData["result"] == null) return [];

      //retorna solo un objeto, no se necesita recorrerlo con un ciclo
      clientes.add(Cliente.fromJson(decodedData["result"]));
    }
    return clientes;
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
