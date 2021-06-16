import 'package:flutter/material.dart';

import 'package:app_gustilandia/src/model/validation_item.dart';

class ValidationFinishShop with ChangeNotifier {
  ValidationItem _cardName = ValidationItem(null, null);
  ValidationItem _cardNumber1 = ValidationItem(null, null);
  ValidationItem _cardNumber2 = ValidationItem(null, null);
  ValidationItem _cardNumber3 = ValidationItem(null, null);
  ValidationItem _cardNumber4 = ValidationItem(null, null);
  ValidationItem _cardCvv = ValidationItem(null, null);
  ValidationItem _cardExpiration = ValidationItem(null, null);

  //Getters
  ValidationItem get cardName => _cardName;
  ValidationItem get cardNumber1 => _cardNumber1;
  ValidationItem get cardNumber2 => _cardNumber2;
  ValidationItem get cardNumber3 => _cardNumber3;
  ValidationItem get cardNumber4 => _cardNumber4;
  ValidationItem get cardCvv => _cardCvv;
  ValidationItem get cardExpiration => _cardExpiration;

  bool get isValid {
    if (_cardName.value != null &&
        _cardNumber1.value != null &&
        _cardNumber2.value != null &&
        _cardNumber3.value != null &&
        _cardNumber4.value != null &&
        _cardExpiration.value != null &&
        _cardCvv.value != null) {
      return true;
    } else {
      return false;
    }
  }

  void changeCardName(String value) {
    if (value.isEmpty || value.length == 0) {
      _cardName = ValidationItem(null, "debe ingresar el nombre de la tarjeta");
    } else {
      _cardName = ValidationItem(value, null);
    }
    notifyListeners();
  }

  void changeCardNumber1(String value) {
    final n = num.tryParse(value);
    if (value.isEmpty || value.length == 0) {
      _cardNumber1 = ValidationItem(null, "Es requerido");
    } else if (value.length < 4) {
      _cardNumber1 = ValidationItem(null, "4 digitos");
    } else if (n == null) {
      _cardNumber1 = ValidationItem(null, "solo digitos");
    } else {
      _cardNumber1 = ValidationItem(value, null);
    }
    notifyListeners();
  }

  void changeCardNumber2(String value) {
    final n = num.tryParse(value);
    if (value.isEmpty || value.length == 0) {
      _cardNumber2 = ValidationItem(null, "Es requerido");
    } else if (value.length < 4) {
      _cardNumber2 = ValidationItem(null, "4 digitos");
    } else if (n == null) {
      _cardNumber2 = ValidationItem(null, "solo digitos");
    } else {
      _cardNumber2 = ValidationItem(value, null);
    }
    notifyListeners();
  }

  void changeCardNumber3(String value) {
    final n = num.tryParse(value);
    if (value.isEmpty || value.length == 0) {
      _cardNumber3 = ValidationItem(null, "Es requerido");
    } else if (value.length < 4) {
      _cardNumber3 = ValidationItem(null, "4 digitos");
    } else if (n == null) {
      _cardNumber3 = ValidationItem(null, "solo digitos");
    } else {
      _cardNumber3 = ValidationItem(value, null);
    }
    notifyListeners();
  }

  void changeCardNumber4(String value) {
    final n = num.tryParse(value);
    if (value.isEmpty || value.length == 0) {
      _cardNumber4 = ValidationItem(null, "Es requerido");
    } else if (value.length < 4) {
      _cardNumber4 = ValidationItem(null, "4 digitos");
    } else if (n == null) {
      _cardNumber4 = ValidationItem(null, "solo digitos");
    } else {
      _cardNumber4 = ValidationItem(value, null);
    }
    notifyListeners();
  }

  void changeCardExpiration(String value) {
    if (value.isEmpty || value.length == 0 || value == "") {
      _cardExpiration = ValidationItem(null, "es requerido");
    } else {
      _cardExpiration = ValidationItem(value, null);
    }
    notifyListeners();
  }

  void changeCardCvv(String value) {
    if (value.isEmpty || value.length == 0) {
      _cardCvv = ValidationItem(null, "es requerido");
    } else if (value.length < 3) {
      _cardCvv = ValidationItem(null, "3 digitos");
    } else {
      _cardCvv = ValidationItem(value, null);
    }
    notifyListeners();
  }
}
