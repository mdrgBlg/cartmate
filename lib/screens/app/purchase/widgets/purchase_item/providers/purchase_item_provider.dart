import 'package:flutter/foundation.dart';

import '/data/repositories/cart_repository.dart';
import '/models/cart_model.dart';

/// Provider owned by a single [PurchaseItem].
class PurchaseItemProvider with ChangeNotifier {
  PurchaseItemProvider({
    required CartRepository cartRepository,
    required CartModel cartModel,
  }) : _cartRepository = cartRepository,
       _cartModel = cartModel;

  final CartRepository _cartRepository;
  final CartModel _cartModel;

  CartModel get cartModel => _cartModel;

  void increaseQuantity() {
    _cartRepository.addProductToCart(_cartModel);
    notifyListeners();
  }

  void decreaseQuantity() {
    _cartRepository.removeProductFromCart(_cartModel);
    notifyListeners();
  }
}
