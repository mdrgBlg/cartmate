import 'package:flutter/material.dart';

import '/data/models/result.dart';
import '/data/repositories/product_repository.dart';
import '/data/repositories/user_repository.dart';
import '/data/repositories/wishlist_repository.dart';
import '/models/categories_model.dart';
import '/models/products_model.dart';
import '/models/user_info_model.dart';

class HomeProvider with ChangeNotifier {
  HomeProvider({
    required WishlistRepository wishlistRepository,
    required ProductRepository productRepository,
    required UserRepository userRepository,
  }) : _wishlistRepository = wishlistRepository,
       _productRepository = productRepository,
       _userRepository = userRepository {
    _wishlistRepository.addListener(_onWishlistChanged);
    _productsFuture = _getProducts();
    _categoriesFuture = _getCategories();
  }

  final WishlistRepository _wishlistRepository;
  final ProductRepository _productRepository;
  final UserRepository _userRepository;

  // Separate errors: both fetches run concurrently from two FutureBuilders.
  Exception? _categoriesError;
  bool get hasCategoriesError => _categoriesError != null;

  Exception? _productsError;
  bool get hasProductsError => _productsError != null;

  List<ProductsModel> _products = [];
  List<ProductsModel> get products => [..._products];

  // Cached so rebuilds of `HomeScreen` don't refetch products and categories.
  late Future<void> _productsFuture;
  late Future<List<CategoriesModel>> _categoriesFuture;
  Future<void> get productsFuture => _productsFuture;
  Future<List<CategoriesModel>> get categoriesFuture => _categoriesFuture;
  UserInfoModel? get userInfoModel => _userRepository.currentUser;

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

  Future<List<CategoriesModel>> _getCategories() async {
    _categoriesError = null;
    final result = await _productRepository.getCategories();
    switch (result) {
      case Success(:final data):
        return data;
      case Failure(:final exception):
        _categoriesError = exception;
        return [];
    }
  }

  Future<void> _getProducts() async {
    _productsError = null;
    final result = await _productRepository.getProducts();
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
    scrollController.dispose();
    super.dispose();
  }
}
