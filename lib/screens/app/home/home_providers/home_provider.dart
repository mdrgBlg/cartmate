import 'dart:collection';

import 'package:flutter/material.dart';

import '/data/repositories/wishlist_repository.dart';
import '../home_models/categories_model.dart';
import '../home_models/products_model.dart';
import 'home_service.dart';

class HomeProvider with ChangeNotifier {
  HomeProvider({required WishlistRepository wishlistRepository})
    : _wishlistRepository = wishlistRepository {
    _wishlistRepository.addListener(_onWishlistChanged);
  }

  final WishlistRepository _wishlistRepository;

  List<ProductsModel> _products = [];
  UnmodifiableListView<ProductsModel> get products =>
      UnmodifiableListView(_products);

  // Cached so rebuilds of `HomeScreen` don't refetch products.
  Future<void>? _productsFuture;
  Future<void> get productsFuture => _productsFuture ??= fetchProducts();

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

  Future<List<CategoriesModel>> fetchCategories() {
    return HomeService.fetchCategories();
  }

  Future<void> fetchProducts() async {
    _products = await HomeService.fetchProducts();
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
