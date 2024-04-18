import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  final String id;
  final String brandName;
  final String iconName;
  final int productCount;

  BrandModel({
    required this.id,
    required this.brandName,
    required this.iconName,
    required this.productCount,
  });

  static BrandModel? fromDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    final json = document.data();
    BrandModel? brandModel;
    try {
      if (json != null) {
        brandModel = BrandModel(
          id: document.id,
          brandName: json["brandName"],
          iconName: json["iconName"],
          productCount: json["productCount"],
        );
      }
    } catch (e) {
      log("EXCEPTION BrandModel $e");
    }
    return brandModel;
  }

  static BrandModel? fromJson(Map<String, dynamic> json) {
    BrandModel? brandModel;
    try {
      brandModel = BrandModel(
        id: json["id"],
        brandName: json["brandName"],
        iconName: json["iconName"],
        productCount: json["productCount"],
      );
    } catch (e) {
      log("EXCEPTION BrandModel $e");
    }
    return brandModel;
  }

  static Map<String, dynamic> brandToMap(BrandModel brand) {
    return {
      'id': brand.id,
      'brandName': brand.brandName,
      'iconName': brand.iconName,
      'productCount': brand.productCount,
    };
  }
}
