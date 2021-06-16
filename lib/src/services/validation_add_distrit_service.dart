import 'package:flutter/material.dart';

import 'package:app_gustilandia/src/model/validation_item.dart';

class ValidationAddDistritoService with ChangeNotifier {
  ValidationDistrito _distrito = new ValidationDistrito(null, null);
  ValidationDistrito _direccion = new ValidationDistrito(null, null);
  ValidationDistrito _referencia = new ValidationDistrito(null, null);

  ValidationDistrito get distrito => _distrito;
  ValidationDistrito get direccion => _direccion;
  ValidationDistrito get referencia => _referencia;

  bool get isValid {
    if (_distrito.value != null &&
        _direccion.value != null &&
        _referencia.value != null) {
      return true;
    } else {
      return false;
    }
  }

  void changeDistrito(int value) {
    if (value.toString().isEmpty || value.toString().length == 0) {
      _distrito = ValidationDistrito(null, "debe seleccionar un distrito");
    } else {
      _distrito = ValidationDistrito(value.toString(), null);
    }
    notifyListeners();
  }

  void changeDireccion(String value) {
    if (value.isEmpty || value.length == 0) {
      _direccion = ValidationDistrito(null, "debe ingresar una dirección");
    } else {
      _direccion = ValidationDistrito(value, null);
    }
    notifyListeners();
  }

  void changeReferencia(String value) {
    if (value.isEmpty || value.length == 0) {
      _referencia = ValidationDistrito(null, "debe ingresar una referencia");
    } else {
      _referencia = ValidationDistrito(value, null);
    }
    notifyListeners();
  }
}
