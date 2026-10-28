import 'package:flutter/material.dart';

import '/data/models/result.dart';
import '/data/repositories/product_repository.dart';
import '/data/repositories/wishlist_repository.dart';
import '/data/models/brand_model.dart';
import '/data/models/categories_model.dart';
import '/data/models/products_model.dart';

class StoreProvider with ChangeNotifier {
  StoreProvider({
    required WishlistRepository wishlistRepository,
    required ProductRepository productRepository,
  }) : _wishlistRepository = wishlistRepository,
       _productRepository = productRepository {
    _wishlistRepository.addListener(_onWishlistChanged);
    _loadFuture = _load();
  }

  final WishlistRepository _wishlistRepository;
  final ProductRepository _productRepository;

  // Separate errors so one failing fetch doesn't hide data from the others.
  Exception? _brandsError;
  bool get hasBrandsError => _brandsError != null;

  Exception? _productsError;
  bool get hasProductsError => _productsError != null;

  Exception? _categoriesError;
  bool get hasCategoriesError => _categoriesError != null;

  // Cached so rebuilds of `StoreScreen` don't refetch everything.
  late final Future<void> _loadFuture;
  Future<void> get loadFuture => _loadFuture;

  List<ProductsModel> _products = [];

  // Lists are stored unmodifiable and keep their identity between
  // notifications so `Selector`s only rebuild when they actually change.
  List<BrandModel> _brands = const [];
  List<BrandModel> get brands => _brands;

  List<CategoriesModel> _categories = const [];
  List<CategoriesModel> get categories => _categories;

  CategoriesModel? _selectedCategory;
  CategoriesModel? get selectedCategory => _selectedCategory;

  List<BrandModel> _categoryBrands = const [];
  List<BrandModel> get categoryBrands => _categoryBrands;

  // Products of the selected category, grouped by brand id.
  Map<String, List<ProductsModel>> _categoryProductsByBrand = const {};

  void changeSelectedCategory(CategoriesModel category) {
    _selectCategory(category);
    notifyListeners();
  }

  void _selectCategory(CategoriesModel? category) {
    _selectedCategory = category;

    final brands = <String, BrandModel>{};
    final productsByBrand = <String, List<ProductsModel>>{};
    for (final product in _products) {
      final brand = product.brandModel;
      if (brand == null || product.categoryId != category?.id) {
        continue;
      }
      brands.putIfAbsent(brand.id, () => brand);
      productsByBrand.putIfAbsent(brand.id, () => []).add(product);
    }

    _categoryBrands = List.unmodifiable(brands.values);
    _categoryProductsByBrand = productsByBrand;
  }

  // Keeps the current selection if it still exists, otherwise the first one.
  CategoriesModel? _resolveSelectedCategory() {
    final currentId = _selectedCategory?.id;
    return _categories.where((e) => e.id == currentId).firstOrNull ??
        _categories.firstOrNull;
  }

  void _updateWishlistFlags() {
    _products = [for (final product in _products) _withCurrentFlag(product)];
  }

  void _onWishlistChanged() {
    _updateWishlistFlags();
    _selectCategory(_selectedCategory);
    notifyListeners();
  }

  ProductsModel _withCurrentFlag(ProductsModel product) {
    final isWishlisted = _wishlistRepository.isWishlisted(product.id);
    return product.isWishlisted == isWishlisted
        ? product
        : product.copyWith(isWishlisted: isWishlisted);
  }

  List<ProductsModel> categoryProductsForBrand(BrandModel brand) =>
      _categoryProductsByBrand[brand.id] ?? const [];

  Future<void> _load() async {
    await Future.wait([_fetchBrands(), _fetchProducts(), _fetchCategories()]);
    _selectCategory(_resolveSelectedCategory());
    notifyListeners();
  }

  Future<void> _fetchBrands() async {
    _brandsError = null;
    final result = await _productRepository.fetchBrands();
    switch (result) {
      case Success(:final data):
        _brands = List.unmodifiable(data);
      case Failure(:final exception):
        _brands = const [];
        _brandsError = exception;
    }
  }

  Future<void> _fetchProducts() async {
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
  }

  Future<void> _fetchCategories() async {
    _categoriesError = null;
    final result = await _productRepository.getCategories();
    switch (result) {
      case Success(:final data):
        _categories = List.unmodifiable(data);
      case Failure(:final exception):
        _categories = const [];
        _categoriesError = exception;
    }
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
