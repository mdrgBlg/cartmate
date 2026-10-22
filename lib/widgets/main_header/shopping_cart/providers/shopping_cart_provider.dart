import 'package:flutter/foundation.dart';

import '/data/repositories/cart_repository.dart';

class ShoppingCartProvider with ChangeNotifier {
  ShoppingCartProvider({required CartRepository cartRepository})
    : _cartRepository = cartRepository {
    _cartRepository.addListener(_onCartChanged);
  }

  final CartRepository _cartRepository;

  int get productNumber => _cartRepository.cartProductNumber;

  void _onCartChanged() => notifyListeners();

  @override
  void dispose() {
    _cartRepository.removeListener(_onCartChanged);
    super.dispose();
  }
}
