import 'package:e_commerce/screens/app/profile/profile_providers/profile_service.dart';
import 'package:flutter/material.dart';

import '../../checkout/checkout_models/checkout_model.dart';
import '/helpers/date_time_service.dart';

class ProfileProvider with ChangeNotifier {
  String? selectedGender;
  DateTime? pickedDate;
  List<CheckoutModel> myOrders = [];

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

  Future<void> fetchMyOrder(String userId) async {
    myOrders = await ProfileService.fetchMyOrder(userId);
  }
}
