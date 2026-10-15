import 'package:flutter/material.dart';

import '/data/models/auth_exception.dart';
import '/data/models/result.dart';
import '/data/repositories/auth_repository.dart';
import '/models/user_info_model.dart';
import '/utils/common_utils.dart';

class LoginProvider with ChangeNotifier {
  LoginProvider({required AuthRepository authRepository})
    : _authRepository = authRepository;

  final AuthRepository _authRepository;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _loginButtonEnable = false;
  bool get loginButtonEnable => _loginButtonEnable;

  AuthErrorType? _error;
  AuthErrorType? get error => _error;

  UserInfoModel? _loggedInUser;
  UserInfoModel? get loggedInUser => _loggedInUser;

  void validateField() {
    _loginButtonEnable =
        emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
    notifyListeners();
  }

  Future<bool> login() async {
    _error = null;

    final result = await _authRepository.login(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    switch (result) {
      case Success(:final data):
        _loggedInUser = data;
        return true;
      case Failure(:final exception):
        _error = fromException(exception);
        return false;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
