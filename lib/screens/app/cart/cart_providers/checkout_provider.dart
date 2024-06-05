import 'package:flutter/material.dart';

class CheckoutProvider with ChangeNotifier {
  bool isButtonEnabled = false;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final eMailController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final zipCodeController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();

  void buttonChecker() {
    isButtonEnabled = firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        eMailController.text.isNotEmpty &&
        countryController.text.isNotEmpty &&
        cityController.text.isNotEmpty &&
        zipCodeController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty &&
        addressController.text.isNotEmpty;
    notifyListeners();
  }
}
