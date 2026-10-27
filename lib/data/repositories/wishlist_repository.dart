import 'package:flutter/foundation.dart';

import '/models/products_model.dart';
import '../models/result.dart';
import '../services/wishlist_service.dart';

/// Single shared instance (registered in DI) and the in-memory source of truth
/// for the wishlist; Firestore is only its persistence. UI must reach it
/// through a provider.
///
/// Stores its own immutable instances (flagged `whishlist: true`) and never
/// mutates models owned by providers. Listeners re-read [isWishlisted] or
/// [products] when notified.
class WishlistRepository with ChangeNotifier {
  WishlistRepository({required WishlistService wishlistService})
    : _wishlistService = wishlistService;

  final WishlistService _wishlistService;

  List<ProductsModel> _products = [];
  bool _isLoaded = false;

  List<ProductsModel> get products => [..._products];

  bool isWishlisted(String productId) =>
      _products.where((element) => element.id == productId).firstOrNull != null;

  /// Drops the cached wishlist so the next user loads their own.
  void clear() {
    _products = [];
    _isLoaded = false;
    notifyListeners();
  }

  Future<Result<void>> getWishlistProducts() async {
    if (_isLoaded) {
      return const Success<void>(null);
    }
    final result = await _wishlistService.fetchWishlistProducts();
    switch (result) {
      case Success(:final data):
        _products = [...data];
        _isLoaded = true;
        if (data.isNotEmpty) {
          notifyListeners();
        }
        return const Success<void>(null);
      case Failure(:final exception):
        return Failure(exception);
    }
  }

  /// Changes memory and notifies synchronously (before the first await), then
  /// persists. On failure the change is rolled back and listeners are
  /// notified again.
  Future<Result<void>> toggleWishlist(ProductsModel product) async {
    if (!_isLoaded) {
      return Failure(Exception('Wishlist not loaded'));
    }

    return isWishlisted(product.id)
        ? _removeFromWishlist(product.id)
        : _addToWishlist(product);
  }

  Future<Result<void>> _addToWishlist(ProductsModel product) async {
    final stored = product.copyWith(whishlist: true);
    _products.add(stored);
    notifyListeners();

    final result = await _wishlistService.addProduct(stored);
    if (result is Failure && _products.remove(stored)) {
      notifyListeners();
    }
    return result;
  }

  Future<Result<void>> _removeFromWishlist(String productId) async {
    final existing = _products
        .where((element) => element.id == productId)
        .firstOrNull;
    if (existing != null) {
      _products.remove(existing);
      notifyListeners();

      final result = await _wishlistService.removeProduct(productId);
      if (result is Failure && !isWishlisted(productId)) {
        _products.add(existing);
        notifyListeners();
      }
      return result;
    }
    return Failure(Exception("Did't find the element"));
  }
}
