import 'package:flutter/cupertino.dart';

class JwtModel extends ChangeNotifier {
  String token;

  setToken(value) {
    token = value;
    notifyListeners();
  }

  isLogged() {
    if (this.token == '' || this.token == null) return false;
    return true;
  }

  getToken() {
    return token;
  }

  deleteToken() {
    token = '';
    notifyListeners();
  }
}
