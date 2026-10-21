import 'package:flutter/foundation.dart';

import '/models/cart_model.dart';

/// Single shared instance (registered in DI) and the source of truth for the
/// cart. In-memory only; SQLite tables are not touched. UI must reach it
/// through a provider. Cart lines are keyed by [CartModel.id] (insertion
/// ordered), so lookups on add/remove do not scan the cart.
class CartRepository with ChangeNotifier {
  final Map<String, CartModel> _cartProducts = {};

  List<CartModel> get cartProducts => _cartProducts.values.toList();

  int get cartProductNumber => _cartProducts.length;

  double get checkoutPrice => _cartProducts.values.fold(
    0,
    (sum, item) =>
        sum +
        item.quantity *
            (item.productModel.price -
                item.productModel.price * (item.productModel.discount / 100)),
  );

  void addProductToCart(CartModel cartModel) {
    final existing = _cartProducts[cartModel.id];
    if (existing != null) {
      ++existing.quantity;
    } else {
      _cartProducts[cartModel.id] = cartModel;
    }

    notifyListeners();
  }

  void removeProductFromCart(CartModel cartModel) {
    final existing = _cartProducts[cartModel.id];
    if (existing != null) {
      --existing.quantity;
      if (existing.quantity <= 0) {
        _cartProducts.remove(cartModel.id);
      }
    }
    notifyListeners();
  }

  void clearCart() {
    _cartProducts.clear();
    notifyListeners();
  }
}
