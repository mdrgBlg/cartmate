import 'package:flutter/material.dart';

import '../../home/home_models/categories_model.dart';
import '../../home/home_models/products_model.dart';
import '../../home/home_providers/home_service.dart';
import '/data/repositories/wishlist_repository.dart';
import '/models/brand_model.dart';
import '/utils/helpers.dart';
import 'store_service.dart';

class StoreProvider with ChangeNotifier {
  StoreProvider({required WishlistRepository wishlistRepository})
    : _wishlistRepository = wishlistRepository {
    _wishlistRepository.addListener(_onWishlistChanged);
  }

  final WishlistRepository _wishlistRepository;

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
    brandsList = await StoreService.fetchBrands();
    await fetchCategories();
    changeSelectedCategory(selectedCategory!);
  }

  Future<void> fetchCategories() async {
    _products = await HomeService.fetchProducts();
    await _wishlistRepository.getWishlistProducts();
    _updateWishlistFlags();
    categoriesList = await HomeService.fetchCategories();
    selectedCategory = categoriesList.first;
    if (categoriesList.isNotEmpty) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _wishlistRepository.removeListener(_onWishlistChanged);
    super.dispose();
  }
}
