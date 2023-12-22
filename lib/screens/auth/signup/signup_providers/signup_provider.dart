import 'package:flutter/material.dart';

import 'signup_service.dart';

class SignUpProvider with ChangeNotifier {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final eMailController = TextEditingController();

  var passwordEmpty = false;
  var confirmPasswordEmpty = false;
  var eMailEmpty = false;

  var signUpButtonEnable = false;

  void validateField() {
    if (passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        eMailController.text.isNotEmpty) {
      signUpButtonEnable = true;
    } else {
      signUpButtonEnable = false;
    }

    passwordEmpty = false;
    confirmPasswordEmpty = false;
    eMailEmpty = false;
  }

  Future<void> signUp() async {
    SignUpService.signUp(eMailController.text, passwordController.text);
  }
}
