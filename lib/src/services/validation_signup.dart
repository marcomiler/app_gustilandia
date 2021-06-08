import 'package:flutter/material.dart';

import 'package:app_gustilandia/src/model/validation_item.dart';

class ValidationSignUpService with ChangeNotifier {
  ValidationItem _nombreCompleto = ValidationItem(null, null);
  ValidationItem _email = ValidationItem(null, null);
  ValidationItem _password = ValidationItem(null, null);

  //Getters
  ValidationItem get nombreCompleto => _nombreCompleto;
  ValidationItem get email => _email;
  ValidationItem get password => _password;
  bool get isValid {
    if (_nombreCompleto.value != null &&
        _email.value != null &&
        _password.value != null) {
      return true;
    } else {
      return false;
    }
  }

  bool get isValidLogin {
    if (_email.value != null && _password.value != null) {
      return true;
    } else {
      return false;
    }
  }

  //Setters
  void changeNombreCompleto(String value) {
    //falta validar que no se ingresen numeros
    if (value.length >= 3) {
      _nombreCompleto = ValidationItem(value, null);
    } else {
      _nombreCompleto =
          ValidationItem(null, "debe ingresar al menos 3 caracteres");
    }
    notifyListeners();
  }

  void changeEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);

    if (regExp.hasMatch(value)) {
      _email = ValidationItem(value, null);
    } else {
      _email = ValidationItem(null, "debe ingresar un formato correcto");
    }
    notifyListeners();
  }

  void changePassword(String value) {
    final n = num.tryParse(value);

    if (value.isEmpty) {
      _password = ValidationItem(null, "este campo es requerido");
    } else if (value.length < 8) {
      _password = ValidationItem(null, "debe ingresar 8 digitos");
    } else if (value.length > 8) {
      _password = ValidationItem(null, "solo se admiten 8 dígitos");
    } else if (n == null) {
      _password = ValidationItem(null, "debe ingresar un formato correcto");
    } else {
      _password = ValidationItem(value, null);
    }

    notifyListeners();
  }

  //visiitar esta pagina para las validaciones:
  //https://codigofacilito.com/articulos/articulo_28_10_2019_17_58_51

  //visitar para volver el password visible o no
  //https://stackoverflow.com/questions/49125064/how-to-show-hide-password-in-textformfield

}
