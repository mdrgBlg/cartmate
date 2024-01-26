import 'package:flutter/material.dart';
import 'login_service.dart';

class LoginProvider with ChangeNotifier {
  final eMailController = TextEditingController();
  final passwordController = TextEditingController();
  final forgotPasswordController = TextEditingController();

  bool loginButtonEnable = false;
  bool forgotPasswordEnable = false;
  bool passwordVisibility = true;

  void validateField() {
    loginButtonEnable = eMailController.text.isNotEmpty && passwordController.text.isNotEmpty;
    notifyListeners();
  }

  void validateForgotPasswordField() {
    forgotPasswordEnable = forgotPasswordController.text.isNotEmpty;
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
