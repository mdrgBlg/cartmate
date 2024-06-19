import 'package:e_commerce/helpers/order_status_enum.dart';
import 'package:flutter/material.dart';

import '../checkout_models/checkout_model.dart';
import '/models/cart_model.dart';
import '/models/response_model.dart';
import 'checkout_service.dart';

class CheckoutProvider with ChangeNotifier {
  CheckoutProvider({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required List<CartModel> cartProducts,
    required this.userId,
    required this.checkoutPrice,
  }) {
    firstNameController.text = firstName;
    lastNameController.text = lastName;
    eMailController.text = email;
    phoneNumberController.text = phoneNumber;
    cartProductsList = cartProducts;
  }
  final String userId;
  final double checkoutPrice;
  bool isButtonEnabled = false;

  List<CartModel> cartProductsList = [];

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

  double getTotalPrice() {
    return checkoutPrice + 8;
  }

  Future<ResponseModel> orderProduct() {
    return CheckoutService.orderProduct(
      CheckoutModel(
        orderId:
            "#${firstNameController.text[0].toLowerCase()}${DateTime.now().toIso8601String().substring(5, 7)}${lastNameController.text[0].toLowerCase()}${DateTime.now().toIso8601String().substring(7, 9)}",
        userId: userId,
        address: addressController.text,
        city: cityController.text,
        country: countryController.text,
        email: eMailController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        checkoutPrice: checkoutPrice,
        postalCode: int.parse(zipCodeController.text),
        items: cartProductsList,
        orderDate: DateTime.now().toString(),
        orderStatus: OrderStatus.pending.index,
      ),
      userId,
    );
  }
}
