import 'package:flutter/material.dart';

import '/utils/extensions/date_time_extension.dart';
import '../../checkout/checkout_models/checkout_model.dart';
import 'profile_service.dart';

class ProfileProvider with ChangeNotifier {
  String? selectedGender;
  DateTime? pickedDate;
  List<CheckoutModel> myOrders = [];

  final controller = TextEditingController();

  void setPickedDate(DateTime date) {
    pickedDate = date;
    controller.text = date.formatDateTime();
    notifyListeners();
  }

  void setGender(String? value) {
    selectedGender = value;
    notifyListeners();
  }

  Future<void> fetchMyOrder(String userId) async {
    myOrders = await ProfileService.fetchMyOrder(userId);
  }

  Future<bool> changeUserName(
    String userId,
    String firstName,
    String lastName,
  ) => ProfileService.updateUserName(userId, firstName, lastName);

  Future<bool> changeEmail(String userId, String value) =>
      ProfileService.updateEmail(userId, value);

  Future<bool> changeUsername(String userId, String value) =>
      ProfileService.updateUsername(userId, value);

  Future<bool> changePhoneNumber(String userId, String value) =>
      ProfileService.updatePhoneNumber(userId, value);

  Future<bool> changeGender(String userId, String? value) =>
      ProfileService.updateGender(userId, value);

  Future<bool> changeDateOfBirth(String userId, String? value) =>
      ProfileService.updateDateOfBirth(userId, value);
}
