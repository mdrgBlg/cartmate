import 'package:flutter/material.dart';

import '/utils/global_enums.dart';
import '/data/models/result.dart';
import '/data/repositories/cart_repository.dart';
import '/data/repositories/order_repository.dart';
import '/data/repositories/user_repository.dart';
import '/models/cart_model.dart';
import '/models/checkout_model.dart';
import '/models/response_model.dart';

class CheckoutProvider with ChangeNotifier {
  CheckoutProvider({
    required UserRepository userRepository,
    required CartRepository cartRepository,
    required OrderRepository orderRepository,
    required this.cartProducts,
    required this.checkoutPrice,
  }) : _userRepository = userRepository,
       _cartRepository = cartRepository,
       _orderRepository = orderRepository {
    final userInfo = userRepository.currentUser;
    firstNameController.text = userInfo?.firstName ?? '';
    lastNameController.text = userInfo?.lastName ?? '';
    emailController.text = userInfo?.email ?? '';
    phoneNumberController.text = userInfo?.phoneNumber ?? '';
  }
  final UserRepository _userRepository;
  final CartRepository _cartRepository;
  final OrderRepository _orderRepository;
  final double checkoutPrice;
  bool isButtonEnabled = false;

  List<CartModel> cartProducts;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final zipCodeController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();

  void buttonChecker() {
    isButtonEnabled =
        firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        countryController.text.isNotEmpty &&
        cityController.text.isNotEmpty &&
        zipCodeController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty &&
        addressController.text.isNotEmpty;

    notifyListeners();
  }

  void clearCart() => _cartRepository.clearCart();

  double getTotalPrice() {
    return checkoutPrice + 8;
  }

  Future<ResponseModel> orderProduct() async {
    final order = CheckoutModel(
      orderId:
          "#${firstNameController.text[0].toLowerCase()}${DateTime.now().toIso8601String().substring(5, 7)}${lastNameController.text[0].toLowerCase()}${DateTime.now().toIso8601String().substring(7, 9)}",
      userId: _userRepository.currentUser?.id ?? '',
      address: addressController.text,
      city: cityController.text,
      country: countryController.text,
      email: emailController.text,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      checkoutPrice: checkoutPrice,
      postalCode: int.parse(zipCodeController.text),
      items: cartProducts,
      orderDate: DateTime.now().toString(),
      orderStatus: OrderStatus.pending.index,
    );
    final result = await _orderRepository.saveOrder(order);
    return switch (result) {
      Success() => ResponseModel(success: true),
      // TODO(l10n): orderSaveError
      Failure() => ResponseModel(
        success: false,
        error: "Something went wrong. Please try again",
      ),
    };
  }
}
