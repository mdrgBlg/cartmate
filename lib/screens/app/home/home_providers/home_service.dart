import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../home_models/categories_model.dart';

class HomeService {
  static Future<List<CategoriesModel>> fetchCategories() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    List<CategoriesModel> categoryList = [];
    try {
      final res = await db.collection("Categories").get();
      for (var e in res.docs) {
        CategoriesModel? categoriesModel = CategoriesModel.fromJson(e.data());
        if (categoriesModel != null && categoriesModel.parentId == null) {
          categoryList.add(categoriesModel);
        }
      }
      // categoryList = res.docs.map((e) => CategoriesModel.fromJson(e.data()!),);
    } catch (e) {
      log("EXCEPTION fetchCategories $e");
    }

    return categoryList;
  }
}
