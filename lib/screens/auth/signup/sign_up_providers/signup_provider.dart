import 'package:flutter/material.dart';
import 'sign_up_service.dart';

class SignUpProvider with ChangeNotifier {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final eMailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();

  bool passwordVisibility = true;
  bool signUpButtonEnable = false;

  void validateField() {
    signUpButtonEnable = passwordController.text.isNotEmpty &&
        eMailController.text.isNotEmpty &&
        firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        usernameController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty;
    notifyListeners();
  }

  void changePasswordVisibility() {
    passwordVisibility = !passwordVisibility;
    notifyListeners();
  }

  Future<void> signUp() async {
    SignUpService.signUp(eMailController.text, passwordController.text);
  }
}
