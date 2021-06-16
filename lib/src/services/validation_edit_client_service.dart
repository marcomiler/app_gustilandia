import 'package:flutter/material.dart';

import 'package:app_gustilandia/src/model/validation_item.dart';

class ValidationEditClientService with ChangeNotifier {
  ValidationItem _phone = ValidationItem(null, null);
  ValidationItem _email = ValidationItem(null, null);
  ValidationItem _direction = ValidationItem(null, null);
  ValidationItem _idDistrito = ValidationItem(null, null);
  ValidationItem _fullName = ValidationItem(null, null);
  //ValidationItem _dni = ValidationItem(null, null);
  ValidationItem _reference = ValidationItem(null, null);

  //Getters
  ValidationItem get phone => _phone;
  ValidationItem get email => _email;
  ValidationItem get direction => _direction;
  ValidationItem get idDistrito => _idDistrito;
  ValidationItem get fullName => _fullName;
  //ValidationItem get dni => _dni;
  ValidationItem get reference => _reference;

  bool get isValid {
    if (_phone.value != null &&
        _email.value != null &&
        _direction.value != null &&
        _idDistrito.value != null &&
        _fullName.value != null &&
        _reference.value != null) {
      return true;
    } else {
      return false;
    }
  }

  void changePhone(String value) {
    final n = num.tryParse(value);
    if (value.isEmpty || value.length == 0) {
      _phone = ValidationItem(null, "debe ingresar un número de celular");
    } else if (n == null) {
      _phone = ValidationItem(null, "debe ingresar un formato correcto");
    } else if (value.length < 7 || value.length > 9) {
      _phone = ValidationItem(null, "debe ingrear entre 7 y 9 caracteres");
    } else {
      _phone = ValidationItem(value, null);
    }
    notifyListeners();
  }

  void changeEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);

    if (value.isEmpty || value.length == 0) {
      _email = ValidationItem(null, "este campo es requerido");
    } else if (!regExp.hasMatch(value)) {
      _email = ValidationItem(null, "debe ingresar un formato correcto");
    } else {
      _email = ValidationItem(value, null);
    }
    notifyListeners();
  }

  void changeDirection(String value) {
    if (value.isEmpty || value.length == 0) {
      _direction = ValidationItem(null, "este campo es requerido");
    } else {
      _direction = ValidationItem(value, null);
    }
    notifyListeners();
  }

  void changeDistrito(int value) {
    if (value.toString().isEmpty || value.toString().length == 0) {
      _idDistrito = ValidationItem(null, "debe seleccionar un distrito");
    } else {
      _idDistrito = ValidationItem(value.toString(), null);
    }
    notifyListeners();
  }

  void changeFullName(String value) {
    if (value.isEmpty || value.length == 0) {
      _fullName = ValidationItem(null, "este campo es requerido");
    } else {
      _fullName = ValidationItem(value, null);
    }
    notifyListeners();
  }

  // void changeDNI(String value) {
  //   final n = num.tryParse(value);

  //   if (value.isEmpty) {
  //     _dni = ValidationItem(null, "este campo es requerido");
  //   } else if (value.length < 8) {
  //     _dni = ValidationItem(null, "debe ingresar 8 digitos");
  //   } else if (value.length > 8) {
  //     _dni = ValidationItem(null, "solo se admiten 8 dígitos");
  //   } else if (n == null) {
  //     _dni = ValidationItem(null, "debe ingresar un formato correcto");
  //   } else {
  //     _dni = ValidationItem(value, null);
  //   }
  //   notifyListeners();
  // }

  void changeReference(String value) {
    if (value.isEmpty || value.length == 0) {
      _reference = ValidationItem(null, "este campo es requerido");
    } else {
      _reference = ValidationItem(value, null);
    }
    notifyListeners();
  }
}
