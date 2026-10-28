import 'package:flutter/foundation.dart';

import '/data/models/result.dart';
import '/data/repositories/wishlist_repository.dart';
import '/data/models/products_model.dart';

class WishlistHeartProvider with ChangeNotifier {
  WishlistHeartProvider({
    required WishlistRepository wishlistRepository,
    required ProductsModel product,
  }) : _wishlistRepository = wishlistRepository,
       _product = product,
       _isWishlisted = product.isWishlisted;

  final WishlistRepository _wishlistRepository;
  final ProductsModel _product;

  bool _isDisposed = false;

  bool _isWishlisted;
  bool get isWishlisted => _isWishlisted;

  // Called directly from the tap, nothing awaited before the repository call.
  Future<void> toggle() async {
    final previous = _isWishlisted;
    _isWishlisted = !previous;
    notifyListeners();
    final result = await _wishlistRepository.toggleWishlist(_product);
    switch (result) {
      case Success():
        break;
      case Failure():
        if (!_isDisposed) {
          _isWishlisted = previous;
          notifyListeners();
        }
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
