import 'package:flutter/foundation.dart';

import '/data/repositories/cart_repository.dart';
import '/data/repositories/wishlist_repository.dart';
import '/models/cart_model.dart';
import '/models/products_model.dart';

class ProductDetailsProvider with ChangeNotifier {
  ProductDetailsProvider({
    required WishlistRepository wishlistRepository,
    required CartRepository cartRepository,
    required ProductsModel product,
  }) : _wishlistRepository = wishlistRepository,
       _cartRepository = cartRepository,
       _product = product {
    _wishlistRepository.addListener(_onWishlistChanged);
  }

  final WishlistRepository _wishlistRepository;
  final CartRepository _cartRepository;

  ProductsModel _product;
  ProductsModel get product => _product;

  String? _selectedSize;
  String? get selectedSize => _selectedSize;

  void setSelectedSize(String? value) {
    _selectedSize = value;
    notifyListeners();
  }

  void addToCart(CartModel cartModel) =>
      _cartRepository.addProductToCart(cartModel);

  void _updateWishlistFlag() {
    final isWishlisted = _wishlistRepository.isWishlisted(_product.id);
    _product = _product.copyWith(isWishlisted: isWishlisted);
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
