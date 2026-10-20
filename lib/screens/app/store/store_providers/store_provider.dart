import 'package:flutter/material.dart';

import '/data/models/result.dart';
import '/data/repositories/product_repository.dart';
import '/data/repositories/wishlist_repository.dart';
import '/models/brand_model.dart';
import '/utils/helpers.dart';
import '../../home/home_models/categories_model.dart';
import '../../home/home_models/products_model.dart';

class StoreProvider with ChangeNotifier {
  StoreProvider({
    required WishlistRepository wishlistRepository,
    required ProductRepository productRepository,
  }) : _wishlistRepository = wishlistRepository,
       _productRepository = productRepository {
    _wishlistRepository.addListener(_onWishlistChanged);
  }

  final WishlistRepository _wishlistRepository;
  final ProductRepository _productRepository;

  Exception? _error;
  bool get hasError => _error != null;

  List<ProductsModel> _products = [];

  CategoriesModel? selectedCategory;
  final scrollController = ScrollController();
  List<CategoriesModel> categoriesList = [];
  List<BrandModel> brandsList = [];
  List<BrandModel> categoryBrandsList = [];
  List<ProductsModel> brandProducts = [];

  void changeSelectedCategory(CategoriesModel value) {
    selectedCategory = value;
    categoryBrandsList = [];

    brandProducts = [];
    for (var e in _products) {
      if (selectedCategory?.id == e.categoryId) {
        if (e.brandModel != null) {
          if (!categoryBrandsList.any(
            (brand) => brand.id == e.brandModel!.id,
          )) {
            categoryBrandsList.add(e.brandModel!);
          }
          brandProducts.add(e);
        }
      }
    }

    notifyListeners();
  }

  void _updateWishlistFlags() {
    _products = [for (final product in _products) _withCurrentFlag(product)];
    brandProducts = [
      for (final product in brandProducts) _withCurrentFlag(product),
    ];
  }

  void _onWishlistChanged() {
    _updateWishlistFlags();
    notifyListeners();
  }

  ProductsModel _withCurrentFlag(ProductsModel product) {
    final isWishlisted = _wishlistRepository.isWishlisted(product.id);
    return product.whishlist == isWishlisted
        ? product
        : product.copyWith(whishlist: isWishlisted);
  }

  List<ProductsModel> getProducts(BrandModel categoryBrand) {
    List<ProductsModel> products = [];
    for (var e in brandProducts) {
      if (categoryBrand.id == e.brandModel?.id) {
        products.add(e);
      }
    }
    return products;
  }

  List<ProductsModel> getBrandProducts(BrandModel brand, {String? categoryId}) {
    final products = Helpers.getBrandProducts(_products, brand);
    if (categoryId == null) {
      return products;
    }
    return products.where((e) => e.categoryId == categoryId).toList();
  }

  Future<void> fetchBrands() async {
    _error = null;
    final result = await _productRepository.fetchBrands();
    switch (result) {
      case Success(:final data):
        brandsList = data;
      case Failure(:final exception):
        brandsList = [];
        _error = exception;
    }
    await fetchCategories();
    if (selectedCategory != null) {
      changeSelectedCategory(selectedCategory!);
    }
  }

  Future<void> fetchCategories() async {
    final productsResult = await _productRepository.fetchProducts();
    switch (productsResult) {
      case Success(:final data):
        _products = data;
      case Failure(:final exception):
        _products = [];
        _error = exception;
    }
    await _wishlistRepository.getWishlistProducts();
    _updateWishlistFlags();

    final categoriesResult = await _productRepository.fetchCategories();
    switch (categoriesResult) {
      case Success(:final data):
        categoriesList = data;
      case Failure(:final exception):
        categoriesList = [];
        _error = exception;
    }
    if (categoriesList.isNotEmpty) {
      selectedCategory = categoriesList.first;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _wishlistRepository.removeListener(_onWishlistChanged);
    super.dispose();
  }
}
