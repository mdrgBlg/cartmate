import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../home_models/categories_model.dart';
import '../home_models/products_model.dart';

class HomeService {
  static Future<List<CategoriesModel>> fetchCategories() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    List<CategoriesModel> categoryList = [];
    try {
      final res = await db.collection("Categories").get();
      for (var e in res.docs) {
        final categoriesModel = CategoriesModel.fromDocument(
          id: e.id,
          json: e.data(),
        );
        if (categoriesModel.parentId == null) {
          categoryList.add(categoriesModel);
        }
      }
    } catch (e) {
      log("EXCEPTION fetchCategories $e");
    }

    return categoryList;
  }

  static Future<List<ProductsModel>> fetchProducts() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    List<ProductsModel> productList = [];
    try {
      final res = await db.collection("Products").get();
      for (var e in res.docs) {
        final productsModel = ProductsModel.fromDocument(
          id: e.id,
          json: e.data(),
        );
        productList.add(productsModel);
      }
    } catch (e) {
      log("EXCEPTION fetchProducts $e");
    }

    return productList;
  }
}
