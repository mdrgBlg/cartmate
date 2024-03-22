import 'package:e_commerce/screens/app/home/home_models/categories_model.dart';
import 'package:e_commerce/screens/app/home/home_providers/home_service.dart';
import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  int screenIndex = 0;
  final scrollController = ScrollController();
  final searchController = TextEditingController();

  void changeScreenIndex(int value) {
    screenIndex = value;
    notifyListeners();
  }

  Future<List<CategoriesModel>> fetchCategories() {
    return HomeService.fetchCategories();
  }
}
