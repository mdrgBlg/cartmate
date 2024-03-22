import 'dart:developer';

import 'package:e_commerce/helpers/helpers.dart';

class CategoriesModel {
  final String categoryName;
  final String iconName;
  final bool isFeatured;
  final String? parentId;

  CategoriesModel({
    required this.categoryName,
    required this.iconName,
    required this.isFeatured,
    required this.parentId,
  });

  static CategoriesModel? fromJson(Map<String, dynamic> json) {
    CategoriesModel? categoriesModel;
    try {
      categoriesModel = CategoriesModel(
        categoryName: json["categoryName"],
        iconName: Helpers.fetchIcon(json["iconName"]),
        isFeatured: json["isFeatured"],
        parentId: json["parentId"],
      );
    } catch (e) {
      log("EXCEPTION CategoriesModel $e");
    }
    return categoriesModel;
  }
}
