import 'package:flutter/material.dart';

import '/data/models/auth_exception.dart';
import '/data/models/result.dart';
import '/data/repositories/auth_repository.dart';
import '/utils/extensions/exception_extension.dart';

class ForgotPasswordProvider with ChangeNotifier {
  ForgotPasswordProvider({required AuthRepository authRepository})
    : _authRepository = authRepository;

  final AuthRepository _authRepository;

  final emailController = TextEditingController();

  bool _submitEnabled = false;
  bool get submitEnabled => _submitEnabled;

  AuthErrorType? _error;
  AuthErrorType? get error => _error;

  void validateField() {
    if (!submitEnabled && emailController.text.isNotEmpty) {
      _submitEnabled = true;
      notifyListeners();
    }
    if (submitEnabled && emailController.text.isEmpty) {
      _submitEnabled = false;
      notifyListeners();
    }
  }

  Future<bool> submit() async {
    _error = null;

    final result = await _authRepository.sendPasswordResetEmail(
      emailController.text.trim(),
    );
    switch (result) {
      case Success():
        return true;
      case Failure(:final exception):
        _error = exception.getAuthErrorType();
        return false;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
