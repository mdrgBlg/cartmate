import 'package:flutter/material.dart';
import 'login_service.dart';

class LoginProvider with ChangeNotifier {
  final eMailController = TextEditingController();
  final passwordController = TextEditingController();

  var eMailEmpty = false;
  var passwordEmpty = false;

  var loginButtonEnable = false;

  void validateField() {
    if (eMailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      loginButtonEnable = true;
    } else {
      loginButtonEnable = false;
    }

    eMailEmpty = eMailController.text.isNotEmpty;
    passwordEmpty = passwordController.text.isNotEmpty;

    notifyListeners();
  }

  Future<void> login() async {
    return LoginService.login(eMailController.text, passwordController.text);
  }
}
