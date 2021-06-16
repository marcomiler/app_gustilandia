import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:app_gustilandia/src/model/distrito_model.dart';
import 'package:app_gustilandia/src/preferences/profile_preferences.dart';

final _URL_GUSTILANDIA = 'http://192.168.0.106:8085/backendgusti';

class DistritoService with ChangeNotifier {
  final _prefs = new PreferenciasUsuario();

  List<Distrito> _processList(http.Response resp) {
    List<Distrito> distritos = [];
    if (resp.statusCode == 200) {
      String body = utf8.decode(resp.bodyBytes);
      final decodedData = json.decode(body);

      if (decodedData == null)
        return [];
      //print(decodedData);
      else {
        for (var item in decodedData) {
          distritos.add(Distrito.fromJson(item));
        }
        //_prefs.setToken = decodedData["result"];//ver la llamada

      }
    }
    return distritos;
  }

  Future<List<Distrito>> getDistritos() async {
    final url = '$_URL_GUSTILANDIA/distrito';
    final resp = await http.get(Uri.parse(url),
        headers: {'content-type': 'application/json', 'Authorization': _prefs.getToken});
    return _processList(resp);
  }
}
