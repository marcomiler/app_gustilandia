import 'dart:convert';
import 'package:app_gustilandia/src/services/shop_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:app_gustilandia/src/preferences/profile_preferences.dart';

final _URL_GUSTILANDIA = 'http://192.168.0.106:8085/backendgusti';

class VentaService with ChangeNotifier {
  String token = new PreferenciasUsuario().getToken;
  String messageError = "";

  Future<bool> registerVenta(List<ProductItem> lstProductos, cardName,
      cardNumber, cardExpirate, cardCvv) async {
    final authData = {
      //"correlativoComprobante": "string",
      "detalleVenta": lstProductos
          .map((e) => {
                "cantidad": e.quantity,
                "idProducto": e.product.idProducto,
                "porcentajeDescuento": 0
              })
          .toList(),
      "idTipoComprobanteSunat": 2,
      "idVenta": 0,
      "nroVenta": 0,
      "tarjeta": {
        "correo": "felipe@gmail.com",
        "cvv": cardCvv,
        "fechaVencimiento": cardExpirate,
        "nroTarjeta": cardNumber
      }
    };
    print(authData);
    print(token);
    final resp = await http.post(Uri.parse('$_URL_GUSTILANDIA/venta'),
        headers: {'content-type': 'application/json', 'Authorization': token},
        body: json.encode(authData));

    String body = utf8.decode(resp.bodyBytes);
    Map<String, dynamic> decodeResp = json.decode(body);

    if (decodeResp["result"] != null) {
      return true;
    } else {
      messageError = decodeResp["message"];
      return false;
    }
  }
}
