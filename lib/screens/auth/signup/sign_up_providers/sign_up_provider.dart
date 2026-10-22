import 'package:flutter/material.dart';

import '/data/models/auth_exception.dart';
import '/data/models/result.dart';
import '/data/repositories/auth_repository.dart';
import '/data/repositories/cart_repository.dart';
import '/utils/common_utils.dart';
import '/utils/extensions/date_time_extension.dart';
import '/utils/global_enums.dart';

class SignUpProvider with ChangeNotifier {
  SignUpProvider({
    required AuthRepository authRepository,
    required CartRepository cartRepository,
  }) : _authRepository = authRepository,
       _cartRepository = cartRepository;

  final AuthRepository _authRepository;
  final CartRepository _cartRepository;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final eMailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final dateController = TextEditingController();

  DateTime? _pickedDate;
  DateTime? get pickedDate => _pickedDate;

  Gender? _selectedGender;
  Gender? get selectedGender => _selectedGender;

  bool _signUpButtonEnable = false;
  bool get signUpButtonEnable => _signUpButtonEnable;

  AuthErrorType? _error;
  AuthErrorType? get error => _error;

  void validateField() {
    _signUpButtonEnable =
        passwordController.text.isNotEmpty &&
        eMailController.text.isNotEmpty &&
        firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        usernameController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty &&
        _selectedGender != null &&
        _pickedDate != null;
    notifyListeners();
  }

  void setPickedDate(DateTime date) {
    _pickedDate = date;
    dateController.text = date.formatDateTime();
    notifyListeners();
  }

  void setGender(Gender? value) {
    _selectedGender = value;
    notifyListeners();
  }

  Future<bool> signUp() async {
    _error = null;

    if (_pickedDate == null || _selectedGender == null) {
      return false;
    }

    final result = await _authRepository.signUp(
      email: eMailController.text.trim(),
      password: passwordController.text.trim(),
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      username: usernameController.text.trim(),
      phoneNumber: phoneNumberController.text.trim(),
      dateOfBirth: _pickedDate!,
      gender: _selectedGender!,
    );
    switch (result) {
      case Success():
        // Sign-up continues through the auto-login restore, so drop any stale cart.
        await _cartRepository.clearCart();
        return true;
      case Failure(:final exception):
        _error = fromException(exception);
        return false;
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    eMailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    dateController.dispose();
    super.dispose();
  }
}
