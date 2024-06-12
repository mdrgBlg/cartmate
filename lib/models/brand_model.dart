import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class BrandModel {
  final String id;
  final String brandName;
  String iconName;
  final int productCount;

  BrandModel({
    required this.id,
    required this.brandName,
    required this.iconName,
    required this.productCount,
  });

  static Future<BrandModel?> fromDocument(
      DocumentSnapshot<Map<String, dynamic>> document) async {
    final json = document.data();
    BrandModel? brandModel;
    try {
      if (json != null) {
        brandModel = BrandModel(
          id: document.id,
          brandName: json["brandName"],
          iconName: await FirebaseStorage.instance
              .ref()
              .child('icons/${json["iconName"]}')
              .getDownloadURL(),
          productCount: json["productCount"],
        );
      }
    } catch (e) {
      log("EXCEPTION BrandModel $e");
    }
    return brandModel;
  }

  static Future<BrandModel?> fromJson(Map<String, dynamic> json) async {
    BrandModel? brandModel;
    try {
      brandModel = BrandModel(
        id: json["id"],
        brandName: json["brandName"],
        iconName: await FirebaseStorage.instance
            .ref()
            .child('icons/${json["iconName"]}')
            .getDownloadURL(),
        productCount: json["productCount"],
      );
    } catch (e) {
      log("EXCEPTION BrandModel $e");
    }
    return brandModel;
  }

  static BrandModel? fromJsonDb(Map<String, dynamic> json) {
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
