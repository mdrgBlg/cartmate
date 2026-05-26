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
  List<BrandModel> categoryBrandsList = [];
  List<ProductsModel> brandProducts = [];

  void setWishlistFlag(List<ProductsModel> productsList,
      List<ProductsModel> whishlistProductsList) {
    for (var e in productsList) {
      if (whishlistProductsList.any((element) => element.id == e.id)) {
        e.whishlist = true;
      }
    }
  }

  void changeSelectedCategory(
      CategoriesModel value, List<ProductsModel> productsList) {
    selectedCategory = value;
    categoryBrandsList = [];

    brandProducts = [];
    for (var e in productsList) {
      if (selectedCategory?.id == e.categoryId) {
        if (e.brandModel != null) {
          if (!categoryBrandsList
              .any((brand) => brand.id == e.brandModel!.id)) {
            categoryBrandsList.add(e.brandModel!);
          }
          brandProducts.add(e);
        }
      }
    }

    notifyListeners();
  }

  List<ProductsModel> getProducts(
    BrandModel categoryBrand,
  ) {
    List<ProductsModel> products = [];
    for (var e in brandProducts) {
      if (categoryBrand.id == e.brandModel?.id) {
        products.add(e);
      }
    }
    return products;
  }

  Future<void> fetchBrands(List<ProductsModel> whishlistProductsList,
      List<ProductsModel> productsList) async {
    brandsList = await StoreService.fetchBrands();
    await fetchCategories(whishlistProductsList, productsList);
    changeSelectedCategory(selectedCategory!, productsList);
  }

  void fetchProducts(
      List<ProductsModel> whishlistProductsList, List<ProductsModel> productsList) {
    setWishlistFlag(productsList, whishlistProductsList);
  }

  Future<void> fetchCategories(
    List<ProductsModel> whishlistProductsList,
    List<ProductsModel> productsList,
  ) async {
    fetchProducts(whishlistProductsList, productsList);
    categoriesList = await HomeService.fetchCategories();
    selectedCategory = categoriesList.first;
    if (categoriesList.isNotEmpty) {
      notifyListeners();
    }
  }
}
