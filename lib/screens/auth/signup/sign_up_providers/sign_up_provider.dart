import 'package:flutter/material.dart';

import '/models/response_model.dart';
import '/models/user_info_model.dart';
import '/utils/extensions/date_time_extension.dart';
import 'sign_up_service.dart';

class SignUpProvider with ChangeNotifier {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final eMailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final dateController = TextEditingController();
  DateTime? pickedDate;

  // List of genders to select from

  String? selectedGender;

  bool passwordVisibility = true;
  bool signUpButtonEnable = false;

  void validateField() {
    signUpButtonEnable =
        passwordController.text.isNotEmpty &&
        eMailController.text.isNotEmpty &&
        firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        usernameController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty &&
        selectedGender != null &&
        dateController.text.isNotEmpty;
    notifyListeners();
  }

  void changePasswordVisibility() {
    passwordVisibility = !passwordVisibility;
    notifyListeners();
  }

  void setPickedDate(DateTime date) {
    pickedDate = date;
    dateController.text = date.formatDateTime();
    notifyListeners();
  }

  void setGender(String? value) {
    selectedGender = value;
    notifyListeners();
  }

  Future<ResponseModel> signUp() async {
    String? newUserId;
    String? error;
    (newUserId, error) = await SignUpService.signUp(
      eMailController.text.trim(),
      passwordController.text.trim(),
    );
    if (newUserId != null) {
      ResponseModel responseModel = await SignUpService.saveUserData(
        UserInfoModel(
          id: newUserId,
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          email: eMailController.text.trim(),
          username: usernameController.text.trim(),
          phoneNumber: phoneNumberController.text.trim(),
          dateOfBirth: pickedDate.toString(),
          gender: selectedGender ?? "",
        ),
      );
      return responseModel;
    }
    return ResponseModel(success: false, error: error);
  }
}
