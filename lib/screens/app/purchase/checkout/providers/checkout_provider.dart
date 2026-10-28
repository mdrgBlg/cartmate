import 'package:flutter/material.dart';

import '/data/models/cart_model.dart';
import '/data/models/checkout_model.dart';
import '/data/models/result.dart';
import '/data/repositories/cart_repository.dart';
import '/data/repositories/order_repository.dart';
import '/data/repositories/user_repository.dart';
import '/utils/global_enums.dart';

const _shippingFee = 8.0;

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
  double get shippingFee => _shippingFee;

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

  double getTotalPrice() {
    return checkoutPrice + shippingFee;
  }

  /// Saves the order and empties the cart once it is stored.
  /// Returns whether the order was saved.
  Future<bool> placeOrder() async {
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
    switch (result) {
      case Success():
        await _cartRepository.clearCart();
        return true;
      case Failure():
        return false;
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    countryController.dispose();
    cityController.dispose();
    zipCodeController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    super.dispose();
  }
}
