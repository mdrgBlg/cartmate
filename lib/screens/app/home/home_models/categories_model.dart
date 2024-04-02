import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/helpers/helpers.dart';

class CategoriesModel {
  final String id;
  final String categoryName;
  final String iconName;
  final bool isFeatured;
  final String? parentId;

  CategoriesModel({
    required this.id,
    required this.categoryName,
    required this.iconName,
    required this.isFeatured,
    required this.parentId,
  });

  static CategoriesModel? fromDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    final json = document.data();
    CategoriesModel? categoriesModel;
    try {
      if (json != null) {
        categoriesModel = CategoriesModel(
          id: document.id,
          categoryName: json["categoryName"],
          iconName: Helpers.fetchIcon(json["iconName"]),
          isFeatured: json["isFeatured"],
          parentId: json["parentId"],
        );
      }
    } catch (e) {
      log("EXCEPTION CategoriesModel $e");
    }
    return categoriesModel;
  }
}
