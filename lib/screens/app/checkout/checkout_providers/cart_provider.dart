import 'package:flutter/foundation.dart';

import '/data/repositories/cart_repository.dart';
import '/models/cart_model.dart';

/// Provider for [CartScreen] only.
class CartProvider with ChangeNotifier {
  CartProvider({required CartRepository cartRepository})
    : _cartRepository = cartRepository {
    _cartRepository.addListener(_onCartChanged);
  }

  final CartRepository _cartRepository;

  List<CartModel> get cartProducts => _cartRepository.cartProducts;

  double get checkoutPrice => _cartRepository.checkoutPrice;

  void increaseQuantity(CartModel cartModel) =>
      _cartRepository.addProductToCart(cartModel);

  void decreaseQuantity(CartModel cartModel) =>
      _cartRepository.removeProductFromCart(cartModel);

  void _onCartChanged() => notifyListeners();

  @override
  void dispose() {
    _cartRepository.removeListener(_onCartChanged);
    super.dispose();
  }
}
