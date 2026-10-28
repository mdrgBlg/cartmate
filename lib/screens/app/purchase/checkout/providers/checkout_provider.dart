import 'package:flutter/material.dart';

import '/utils/constants/checkout_constants.dart';
import '/utils/global_enums.dart';
import '/data/models/result.dart';
import '/data/repositories/cart_repository.dart';
import '/data/repositories/order_repository.dart';
import '/data/repositories/user_repository.dart';
import '/data/models/cart_model.dart';
import '/data/models/checkout_model.dart';

class CheckoutProvider with ChangeNotifier {
  CheckoutProvider({
    required UserRepository userRepository,
    required CartRepository cartRepository,
    required OrderRepository orderRepository,
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
  bool isButtonEnabled = false;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final zipCodeController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();

  List<CartModel> get cartProducts => _cartRepository.cartProducts;
  double get checkoutPrice => _cartRepository.checkoutPrice;
  double get shippingFee => CheckoutConstants.shippingFee;

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
    return checkoutPrice + shippingFee;
  }

  /// Returns whether the order was saved.
  Future<bool> orderProduct() async {
    final order = CheckoutModel(
      orderId: '',
      userId: _userRepository.currentUser?.id ?? '',
      address: addressController.text,
      city: cityController.text,
      country: countryController.text,
      email: emailController.text,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      checkoutPrice: getTotalPrice(),
      postalCode: zipCodeController.text.trim(),
      items: _cartRepository.cartProducts,
      orderDate: DateTime.now().toString(),
      orderStatus: OrderStatus.pending.index,
    );
    final result = await _orderRepository.saveOrder(order);
    return switch (result) {
      Success() => true,
      Failure() => false,
    };
  }
}
