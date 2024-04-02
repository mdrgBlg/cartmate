import 'dart:developer';

import 'package:e_commerce/screens/app/home/home_models/categories_model.dart';
import 'package:e_commerce/screens/app/home/home_providers/home_service.dart';
import 'package:flutter/material.dart';

import '../home_models/products_model.dart';

class HomeProvider with ChangeNotifier {
  int screenIndex = 0;
  bool isFocused = false;
  List<ProductsModel> productsList = [];
  List<ProductsModel> searchedProductsList = [];
  final scrollController = ScrollController();
  final searchController = TextEditingController();
  final searchScrollController = ScrollController();

  void changeScreenIndex(int value) {
    screenIndex = value;
    notifyListeners();
  }

  void searchProduct(String input) {
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

  Future<void> fetchProducts() async {
    productsList = await HomeService.fetchProducts();
  }
}
