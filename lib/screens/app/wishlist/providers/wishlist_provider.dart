import 'package:flutter/material.dart';

import '/data/models/result.dart';
import '/data/repositories/wishlist_repository.dart';
import '/data/models/products_model.dart';

class WishlistProvider with ChangeNotifier {
  WishlistProvider({required WishlistRepository wishlistRepository})
    : _wishlistRepository = wishlistRepository {
    _wishlistRepository.addListener(_onWishlistChanged);
    _wishlistFuture = _fetchWishlist();
  }

  final WishlistRepository _wishlistRepository;

  late final Future<Exception?> _wishlistFuture;
  Future<Exception?> get wishlistFuture => _wishlistFuture;

  List<ProductsModel> _products = [];
  List<ProductsModel> get products => [..._products];

  Exception? _error;
  bool get hasError => _error != null;

  // The list always mirrors the repository content, so un-hearting an item
  // removes it from this list.
  void _updateProducts() {
    _products = [
      for (final product in _wishlistRepository.products)
        product.isWishlisted ? product : product.copyWith(isWishlisted: true),
    ];
  }

  void _onWishlistChanged() {
    _updateProducts();
    notifyListeners();
  }

  // Started once from the constructor and awaited by `WishlistScreen`'s
  // `FutureBuilder`, which owns the loading state.
  Future<Exception?> _fetchWishlist() async {
    final result = await _wishlistRepository.getWishlistProducts();
    switch (result) {
      case Success():
        _updateProducts();
        return null;
      case Failure(:final exception):
        _products = [];
        return exception;
    }
  }

  @override
  void dispose() {
    _wishlistRepository.removeListener(_onWishlistChanged);
    super.dispose();
  }
}
