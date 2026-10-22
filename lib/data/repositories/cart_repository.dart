import 'package:flutter/foundation.dart';

import '/models/cart_model.dart';
import '../models/result.dart';
import '../services/cart_service.dart';

/// Single shared instance (registered in DI) and the source of truth for the
/// cart. Held in memory and mirrored best-effort to SQLite through
/// [CartService] (failures are logged there). UI must reach it through a
/// provider. Cart lines are keyed by [CartModel.id] (insertion ordered), so
/// lookups on add/remove do not scan the cart.
class CartRepository with ChangeNotifier {
  CartRepository({required CartService cartService})
    : _cartService = cartService;

  final CartService _cartService;
  final Map<String, CartModel> _cartProducts = {};

  /// Last queued database write. New writes wait for it, so they reach the
  /// database in call order.
  Future<void> _lastWrite = Future.value();

  List<CartModel> get cartProducts => _cartProducts.values.toList();

  int get cartProductNumber => _cartProducts.length;

  double get checkoutPrice =>
      _cartProducts.values.fold(0, (sum, item) => sum + item.getTotalPrice);

  void addProductToCart(CartModel cartModel) {
    final existing = _cartProducts[cartModel.id];
    if (existing != null) {
      ++existing.quantity;
    } else {
      _cartProducts[cartModel.id] = cartModel;
    }

    notifyListeners();
    _queueWrite(() => _cartService.saveItem(existing ?? cartModel));
  }

  void removeProductFromCart(CartModel cartModel) {
    final existing = _cartProducts[cartModel.id];
    if (existing != null) {
      --existing.quantity;
      if (existing.quantity <= 0) {
        _cartProducts.remove(cartModel.id);
        _queueWrite(() => _cartService.deleteItem(existing));
      } else {
        _queueWrite(() => _cartService.saveItem(existing));
      }
    }
    notifyListeners();
  }

  /// Empties the in-memory cart now and the stored cart after earlier queued
  /// writes. The future completes when the stored cart is cleared.
  Future<Result<void>> clearCart() {
    _cartProducts.clear();
    notifyListeners();
    return _queueWrite(_cartService.clearCart);
  }

  /// Replaces the in-memory cart with the stored one. Meant to be called once
  /// when a session is restored.
  Future<Result<void>> loadCart() async {
    final result = await _cartService.fetchCart();
    switch (result) {
      case Success(:final data):
        _cartProducts
          ..clear()
          ..addEntries(data.map((item) => MapEntry(item.id, item)));
        notifyListeners();
        return const Success<void>(null);
      case Failure(:final exception):
        return Failure(exception);
    }
  }

  Future<Result<void>> _queueWrite(Future<Result<void>> Function() write) {
    final result = _lastWrite.then((_) => write());
    _lastWrite = result;
    return result;
  }
}
