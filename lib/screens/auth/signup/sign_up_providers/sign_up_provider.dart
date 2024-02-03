import 'package:flutter/material.dart';
import '/models/response_model.dart';
import '/models/user_info_model.dart';
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

  Future<ResponseModel> signUp() async {
    String? newUserId;
    String? error;
    (newUserId, error) = await SignUpService.signUp(eMailController.text.trim(), passwordController.text.trim());
    if (newUserId != null) {
      ResponseModel responseModel = await SignUpService.saveUserData(
        UserInfoModel(
          id: newUserId,
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          email: eMailController.text.trim(),
          username: usernameController.text.trim(),
          phoneNumber: phoneNumberController.text.trim(),
        ),
      );
      return responseModel;
    }
    return ResponseModel(success: false, error: error);
  }
}
