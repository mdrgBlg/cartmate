import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '/data/repositories/wishlist_repository.dart';
import '/screens/app/home/home_models/products_model.dart';
import '/screens/app/home/home_providers/home_service.dart';

class SearchProvider with ChangeNotifier {
  SearchProvider({required WishlistRepository wishlistRepository})
    : _wishlistRepository = wishlistRepository;

  final WishlistRepository _wishlistRepository;

  final searchController = TextEditingController();
  final searchScrollController = ScrollController();
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 600));

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
    _debouncer.call(_searchProducts);
  }

  void clearInput() {
    _debouncer.cancel();
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
      _products = await HomeService.fetchProducts();
      if (_isDisposed) {
        return;
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
    _debouncer.cancel();
    searchController.dispose();
    searchScrollController.dispose();
    super.dispose();
  }
}
