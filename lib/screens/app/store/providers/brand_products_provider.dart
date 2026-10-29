import 'package:flutter/material.dart';

import '/data/models/result.dart';
import '/data/repositories/product_repository.dart';
import '/data/repositories/wishlist_repository.dart';
import '/data/models/brand_model.dart';
import '/data/models/products_model.dart';

class BrandProductsProvider with ChangeNotifier {
  BrandProductsProvider({
    required BrandModel brandModel,
    required ProductRepository productRepository,
    required WishlistRepository wishlistRepository,
    String? categoryId,
  }) : _brandModel = brandModel,
       _categoryId = categoryId,
       _productRepository = productRepository,
       _wishlistRepository = wishlistRepository {
    _wishlistRepository.addListener(_onWishlistChanged);
    _loadFuture = _load();
  }

  final BrandModel _brandModel;
  // When set, only products of this category are shown.
  final String? _categoryId;
  final ProductRepository _productRepository;
  final WishlistRepository _wishlistRepository;

  Exception? _error;
  bool get hasError => _error != null;

  BrandModel get brandModel => _brandModel;

  // Cached so rebuilds of `BrandProductsScreen` don't reload.
  late Future<void> _loadFuture;
  Future<void> get loadFuture => _loadFuture;

  void reload() {
    _loadFuture = _load();
    notifyListeners();
  }

  List<ProductsModel> _products = const [];
  List<ProductsModel> get products => _products;

  bool _matches(ProductsModel product) =>
      product.brandModel?.id == _brandModel.id &&
      (_categoryId == null || product.categoryId == _categoryId);

  void _updateWishlistFlags() {
    _products = List.unmodifiable([
      for (final product in _products) _withCurrentFlag(product),
    ]);
  }

  void _onWishlistChanged() {
    _updateWishlistFlags();
    notifyListeners();
  }

  ProductsModel _withCurrentFlag(ProductsModel product) {
    final isWishlisted = _wishlistRepository.isWishlisted(product.id);
    return product.isWishlisted == isWishlisted
        ? product
        : product.copyWith(isWishlisted: isWishlisted);
  }

  Future<void> _load() async {
    _error = null;
    final result = await _productRepository.getProducts();
    switch (result) {
      case Success(:final data):
        _products = data.where(_matches).toList();
      case Failure(:final exception):
        _products = const [];
        _error = exception;
    }
    await _wishlistRepository.getWishlistProducts();
    _updateWishlistFlags();
    notifyListeners();
  }

  // Loading can finish after the user has left the screen.
  bool _disposed = false;

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _wishlistRepository.removeListener(_onWishlistChanged);
    super.dispose();
  }
}
