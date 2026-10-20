import 'dart:collection';

import 'package:flutter/material.dart';

import '/data/models/result.dart';
import '/data/repositories/product_repository.dart';
import '/data/repositories/wishlist_repository.dart';
import '../home_models/categories_model.dart';
import '../home_models/products_model.dart';

class HomeProvider with ChangeNotifier {
  HomeProvider({
    required WishlistRepository wishlistRepository,
    required ProductRepository productRepository,
  }) : _wishlistRepository = wishlistRepository,
       _productRepository = productRepository {
    _wishlistRepository.addListener(_onWishlistChanged);
    _productsFuture = _fetchProducts();
    _categoriesFuture = _fetchCategories();
  }

  final WishlistRepository _wishlistRepository;
  final ProductRepository _productRepository;

  // Separate errors: both fetches run concurrently from two FutureBuilders.
  Exception? _categoriesError;
  bool get hasCategoriesError => _categoriesError != null;

  Exception? _productsError;
  bool get hasProductsError => _productsError != null;

  List<ProductsModel> _products = [];
  UnmodifiableListView<ProductsModel> get products =>
      UnmodifiableListView(_products);

  // Cached so rebuilds of `HomeScreen` don't refetch products and categories.
  late Future<void> _productsFuture;
  late Future<List<CategoriesModel>> _categoriesFuture;
  Future<void> get productsFuture => _productsFuture;
  Future<List<CategoriesModel>> get categoriesFuture => _categoriesFuture;

  final scrollController = ScrollController();

  void _updateWishlistFlags() {
    _products = [for (final product in _products) _withCurrentFlag(product)];
  }

  void _onWishlistChanged() {
    _updateWishlistFlags();
    notifyListeners();
  }

  ProductsModel _withCurrentFlag(ProductsModel product) {
    final isWishlisted = _wishlistRepository.isWishlisted(product.id);
    return product.copyWith(whishlist: isWishlisted);
  }

  List<ProductsModel> getProductsForCategory(String id) {
    return _products.where((element) => element.categoryId == id).toList();
  }

  Future<List<CategoriesModel>> _fetchCategories() async {
    _categoriesError = null;
    final result = await _productRepository.fetchCategories();
    switch (result) {
      case Success(:final data):
        return data;
      case Failure(:final exception):
        _categoriesError = exception;
        return [];
    }
  }

  Future<void> _fetchProducts() async {
    _productsError = null;
    final result = await _productRepository.fetchProducts();
    switch (result) {
      case Success(:final data):
        _products = data;
      case Failure(:final exception):
        _products = [];
        _productsError = exception;
    }
    await _wishlistRepository.getWishlistProducts();
    _updateWishlistFlags();
    notifyListeners();
  }

  @override
  void dispose() {
    _wishlistRepository.removeListener(_onWishlistChanged);
    super.dispose();
  }
}
