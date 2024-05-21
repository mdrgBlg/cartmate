import 'package:flutter/material.dart';

import '/helpers/date_time_service.dart';

class ProfileProvider with ChangeNotifier {
  String? selectedGender;
  DateTime? pickedDate;

  final controller = TextEditingController();

  void setPickedDate(DateTime date) {
    pickedDate = date;
    controller.text = DateTimeService.formatDateTime(
      date.toString(),
    );
    notifyListeners();
  }

  void setGender(String? value) {
    selectedGender = value;
    notifyListeners();
  }
}
