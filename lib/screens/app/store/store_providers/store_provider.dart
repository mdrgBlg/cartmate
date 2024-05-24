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

  void setWishlistFlag(List<ProductsModel> productsList,
      List<ProductsModel> whishlistProductsList) {
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
        if (e.brandModel != null &&
            !categoryBrandsList.contains(e.brandModel!)) {
          categoryBrandsList.add(e.brandModel!);
          brandProducts.add(e);
        }
      }
    }
    notifyListeners();
  }

  void setProductCount(
      List<ProductsModel> productsList, List<ProductsModel> cartList) {
    final cartMap = {
      for (var item in cartList) item.id: item.count,
    };
    for (var product in productsList) {
      if (cartMap.containsKey(product.id)) {
        product.count = cartMap[product.id]!;
      }
    }
  }

  Future<void> fetchBrands() async {
    brandsList = await StoreService.fetchBrands();
  }

  Future<void> fetchProducts(List<ProductsModel> whishlistProductsList,
      List<ProductsModel> cartList) async {
    productsList = await HomeService.fetchProducts();
    setWishlistFlag(productsList, whishlistProductsList);
    setProductCount(productsList, cartList);
  }

  Future<void> fetchCategories(List<ProductsModel> whishlistProductsList,
      List<ProductsModel> cartList) async {
    await fetchProducts(
      whishlistProductsList,
      cartList,
    );
    categoriesList = await HomeService.fetchCategories();
    selectedCategory = categoriesList.first;
    if (categoriesList.isNotEmpty) {
      notifyListeners();
    }
  }
}
