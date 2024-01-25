import 'package:flutter/material.dart';
import 'login_service.dart';

class LoginProvider with ChangeNotifier {
  final eMailController = TextEditingController();
  final passwordController = TextEditingController();

  bool eMailEmpty = false;
  bool passwordEmpty = false;
  bool loginButtonEnable = false;
  bool passwordVisibility = true;

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

  void changeVisibility() {
    passwordVisibility = !passwordVisibility;
    notifyListeners();
  }

  Future<void> login() async {
    return LoginService.login(eMailController.text, passwordController.text);
  }
}
