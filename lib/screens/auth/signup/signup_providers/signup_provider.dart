import 'package:flutter/material.dart';

import 'sign_up_service.dart';

class SignUpProvider with ChangeNotifier {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final eMailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool passwordVisibility = true;

  bool passwordEmpty = false;
  bool eMailEmpty = false;

  bool signUpButtonEnable = false;

  void validateField() {
    if (passwordController.text.isNotEmpty && confirmPasswordController.text.isNotEmpty && eMailController.text.isNotEmpty) {
      signUpButtonEnable = true;
    } else {
      signUpButtonEnable = false;
    }

    passwordEmpty = false;
    eMailEmpty = false;
  }

  void changePasswordVisibility() {
    passwordVisibility = !passwordVisibility;
    notifyListeners();
  }

  Future<void> signUp() async {
    SignUpService.signUp(eMailController.text, passwordController.text);
  }
}
