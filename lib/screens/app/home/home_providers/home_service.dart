import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/screens/app/home/home_models/products_model.dart';

import '../home_models/categories_model.dart';

class HomeService {
  static Future<List<CategoriesModel>> fetchCategories() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    List<CategoriesModel> categoryList = [];
    try {
      final res = await db.collection("Categories").get();
      for (var e in res.docs) {
        CategoriesModel? categoriesModel = CategoriesModel.fromDocument(e);
        if (categoriesModel != null && categoriesModel.parentId == null) {
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
        ProductsModel? productsModel = ProductsModel.fromDocument(e);
        if (productsModel != null) {
          productList.add(productsModel);
        }
      }
    } catch (e) {
      log("EXCEPTION fetchProducts $e");
    }

    return productList;
  }
}
