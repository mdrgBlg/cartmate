import 'package:flutter/foundation.dart';

import '/data/repositories/cart_repository.dart';

class ProductCartQuantityProvider with ChangeNotifier {
  ProductCartQuantityProvider({
    required CartRepository cartRepository,
    required String productId,
  }) : _cartRepository = cartRepository,
       _productId = productId {
    _cartRepository.addListener(_onCartChanged);
  }

  final CartRepository _cartRepository;
  final String _productId;

  int get quantity => _cartRepository.cartProducts
      .where((c) => c.productModel.id == _productId)
      .fold(0, (sum, c) => sum + c.quantity);

  void _onCartChanged() => notifyListeners();

  @override
  void dispose() {
    _cartRepository.removeListener(_onCartChanged);
    super.dispose();
  }
}
