import 'package:flutter/foundation.dart';

import '/models/cart_model.dart';

/// Single shared instance (registered in DI) and the source of truth for the
/// cart. In-memory only; SQLite tables are not touched. UI must reach it
/// through a provider.
class CartRepository with ChangeNotifier {
  final List<CartModel> _cartProducts = [];

  List<CartModel> get cartProducts => [..._cartProducts];

  int get cartProductNumber => _cartProducts.length;

  double get checkoutPrice => _cartProducts.fold(
    0,
    (sum, item) =>
        sum +
        item.quantity *
            (item.productModel.price -
                item.productModel.price * (item.productModel.discount / 100)),
  );

  void addProductToCart(CartModel cartModel) {
    bool elementExists = false;

    for (var e in _cartProducts) {
      if (e.productModel.id == cartModel.productModel.id &&
          e.size == cartModel.size) {
        ++e.quantity;
        elementExists = true;
        break;
      }
    }

    if (!elementExists) {
      _cartProducts.add(cartModel);
    }

    notifyListeners();
  }

  void removeProductFromCart(CartModel cartModel) {
    int? indexToRemove;
    for (int i = 0; i < _cartProducts.length; i++) {
      if (_cartProducts[i].productModel.id == cartModel.productModel.id &&
          _cartProducts[i].size == cartModel.size) {
        --_cartProducts[i].quantity;
        if (_cartProducts[i].quantity == 0) {
          indexToRemove = i;
        }
        break;
      }
    }
    if (indexToRemove != null) {
      _cartProducts.removeAt(indexToRemove);
    }
    notifyListeners();
  }

  void clearCart() {
    _cartProducts.clear();
    notifyListeners();
  }
}
