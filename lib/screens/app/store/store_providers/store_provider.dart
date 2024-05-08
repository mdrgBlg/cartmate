import 'package:flutter/material.dart';

import '../../home/home_models/categories_model.dart';
import '../../home/home_models/products_model.dart';
import '../../home/home_providers/home_service.dart';
import '/models/brand_model.dart';
import 'store_service.dart';

class StoreProvider with ChangeNotifier {
  CategoriesModel? selectedCategory;
  final scrollController = ScrollController();
  List<CategoriesModel> categoriesList = [];
  List<BrandModel> brandsList = [];
  List<ProductsModel> productsList = [];
  List<BrandModel> categoryBrandsList = [];
  List<ProductsModel> brandProducts = [];

  void setWishlistFlag(List<ProductsModel> productsList, List<ProductsModel> whishlistProductsList) {
    for (var e in productsList) {
      if (whishlistProductsList.any((element) => element.id == e.id)) {
        e.whishlist = true;
      }
    }
  }

  void changeSelectedCategory(CategoriesModel value) {
    selectedCategory = value;
    categoryBrandsList = [];
    brandProducts = [];
    for (var e in productsList) {
      if (selectedCategory?.id == e.categoryId) {
        if (e.brandModel != null && !categoryBrandsList.contains(e.brandModel!)) {
          categoryBrandsList.add(e.brandModel!);
          brandProducts.add(e);
        }
      }
    }
    notifyListeners();
  }

  Future<void> fetchBrands() async {
    brandsList = await StoreService.fetchBrands();
  }

  Future<void> fetchProducts(List<ProductsModel> whishlistProductsList) async {
    productsList = await HomeService.fetchProducts();
    setWishlistFlag(productsList, whishlistProductsList);
  }

  Future<void> fetchCategories(List<ProductsModel> whishlistProductsList) async {
    await fetchProducts(whishlistProductsList);
    categoriesList = await HomeService.fetchCategories();
    selectedCategory = categoriesList.first;
    if (categoriesList.isNotEmpty) {
      notifyListeners();
    }
  }
}
