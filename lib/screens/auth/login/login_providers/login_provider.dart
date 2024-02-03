import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/response_model.dart';
import '/providers/main_provider.dart';
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

  Future<ResponseModel> login(BuildContext context) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    String? userId;
    String? error;
    (userId, error) = await LoginService.login(eMailController.text.trim(), passwordController.text.trim());
    if (userId != null && userId.isNotEmpty) {
      ResponseModel responseModel = await mainProvider.fetchUserInfo(userId);
      return responseModel;
    }

    return ResponseModel(success: false, error: error);
  }
}
