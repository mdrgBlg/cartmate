import 'package:flutter/foundation.dart';

import '/data/repositories/wishlist_repository.dart';
import '/screens/app/home/home_models/products_model.dart';

class ProductDetailsProvider with ChangeNotifier {
  ProductDetailsProvider({
    required WishlistRepository wishlistRepository,
    required ProductsModel product,
  }) : _wishlistRepository = wishlistRepository,
       _product = product {
    _wishlistRepository.addListener(_onWishlistChanged);
  }

  final WishlistRepository _wishlistRepository;

  ProductsModel _product;
  ProductsModel get product => _product;

  String? _selectedSize;
  String? get selectedSize => _selectedSize;

  void setSelectedSize(String? value) {
    _selectedSize = value;
    notifyListeners();
  }

  void _updateWishlistFlag() {
    final isWishlisted = _wishlistRepository.isWishlisted(_product.id);
    _product = _product.copyWith(whishlist: isWishlisted);
  }

  void _onWishlistChanged() {
    _updateWishlistFlag();
    notifyListeners();
  }

  @override
  void dispose() {
    _wishlistRepository.removeListener(_onWishlistChanged);
    super.dispose();
  }
}
