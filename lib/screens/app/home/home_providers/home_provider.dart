import 'package:flutter/material.dart';

import '../home_models/categories_model.dart';
import '../home_models/products_model.dart';
import 'home_service.dart';

class HomeProvider with ChangeNotifier {
  int screenIndex = 0;
  bool isFocused = false;

  List<ProductsModel> searchedProductsList = [];

  final scrollController = ScrollController();
  final searchController = TextEditingController();
  final searchScrollController = ScrollController();

  void changeScreenIndex(int value) {
    screenIndex = value;
    notifyListeners();
  }

  void searchProduct(String input, List<ProductsModel> productsList) {
    searchedProductsList = productsList.where((element) {
      return element.productName.toLowerCase().contains(
            input.toLowerCase(),
          );
    }).toList();

    notifyListeners();
  }

  void clearInput() {
    searchController.clear();
    searchedProductsList = [];
    notifyListeners();
  }

  void focusChange(bool value) {
    isFocused = value;
    notifyListeners();
  }

  Future<List<CategoriesModel>> fetchCategories() {
    return HomeService.fetchCategories();
  }

  List<ProductsModel> getProductsForCategory(
      String id, List<ProductsModel> productsList) {
    return productsList.where((element) => element.categoryId == id).toList();
  }
}
