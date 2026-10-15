import 'package:flutter/material.dart';

import '/data/models/auth_exception.dart';
import '/data/models/result.dart';
import '/data/repositories/auth_repository.dart';
import '/utils/common_utils.dart';
import '/utils/extensions/date_time_extension.dart';

class SignUpProvider with ChangeNotifier {
  SignUpProvider({required AuthRepository authRepository})
    : _authRepository = authRepository;

  final AuthRepository _authRepository;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final eMailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final dateController = TextEditingController();

  DateTime? _pickedDate;
  DateTime? get pickedDate => _pickedDate;

  String? _selectedGender;
  String? get selectedGender => _selectedGender;

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
        dateController.text.isNotEmpty;
    notifyListeners();
  }

  void setPickedDate(DateTime date) {
    _pickedDate = date;
    dateController.text = date.formatDateTime();
    notifyListeners();
  }

  void setGender(String? value) {
    _selectedGender = value;
    notifyListeners();
  }

  Future<bool> signUp() async {
    _error = null;

    final result = await _authRepository.signUp(
      email: eMailController.text.trim(),
      password: passwordController.text.trim(),
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      username: usernameController.text.trim(),
      phoneNumber: phoneNumberController.text.trim(),
      dateOfBirth: _pickedDate.toString(),
      gender: _selectedGender ?? "",
    );
    switch (result) {
      case Success():
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
