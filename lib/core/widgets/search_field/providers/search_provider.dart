import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';

import '/data/models/result.dart';
import '/data/repositories/product_repository.dart';
import '/data/repositories/wishlist_repository.dart';
import '/models/products_model.dart';

class SearchProvider with ChangeNotifier {
  SearchProvider({
    required WishlistRepository wishlistRepository,
    required ProductRepository productRepository,
  }) : _wishlistRepository = wishlistRepository,
       _productRepository = productRepository;

  final WishlistRepository _wishlistRepository;
  final ProductRepository _productRepository;

  Exception? _error;
  bool get hasError => _error != null;

  final searchController = TextEditingController();
  final searchScrollController = ScrollController();
  Timer? _debounce;

  bool _isDisposed = false;

  // Fetched lazily on the first query and reused for later ones.
  List<ProductsModel> _products = [];

  List<ProductsModel> _searchedProducts = [];
  UnmodifiableListView<ProductsModel> get searchedProducts =>
      UnmodifiableListView(_searchedProducts);

  bool _isFocused = false;
  bool get isFocused => _isFocused;

  bool get hasQuery => searchController.text.isNotEmpty;

  bool get showResults => _isFocused && _searchedProducts.isNotEmpty;

  void focusChange(bool value) {
    _isFocused = value;
    notifyListeners();
  }

  void onQueryChanged(String value) {
    if (value.isEmpty) {
      // Cleared right away, stale results must not outlive the input.
      clearInput();
      return;
    }
    notifyListeners();
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 600), _searchProducts);
  }

  void clearInput() {
    _debounce?.cancel();
    searchController.clear();
    _searchedProducts = [];
    notifyListeners();
  }

  /// Returns the product with its current wishlist flag, ready for details.
  ProductsModel productAt(int index) {
    final product = _searchedProducts[index];
    return product.copyWith(
      whishlist: _wishlistRepository.isWishlisted(product.id),
    );
  }

  Future<void> _searchProducts() async {
    if (_products.isEmpty) {
      _error = null;
      final result = await _productRepository.getProducts();
      if (_isDisposed) {
        return;
      }
      switch (result) {
        case Success(:final data):
          _products = data;
        case Failure(:final exception):
          _error = exception;
      }
    }

    // Read the latest input, it may have changed while products were loading.
    final query = searchController.text.toLowerCase();
    _searchedProducts = query.isEmpty
        ? []
        : _products
              .where(
                (element) => element.productName.toLowerCase().contains(query),
              )
              .toList();
    notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    _debounce?.cancel();
    searchController.dispose();
    searchScrollController.dispose();
    super.dispose();
  }
}
