import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/brand_model.dart';

class ProductsModel {
  final String id;
  final BrandModel? brandModel;
  final String categoryId;
  final String currency;
  final String productImage;
  final String productName;
  final int discount;
  final int price;
  final List<String>? productSize;
  final int stock;

  ProductsModel({
    required this.id,
    required this.brandModel,
    required this.categoryId,
    required this.currency,
    required this.productImage,
    required this.productName,
    required this.discount,
    required this.price,
    required this.productSize,
    required this.stock,
  });

  static ProductsModel? fromDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    final json = document.data();
    ProductsModel? productsModel;
    try {
      if (json != null) {
        productsModel = ProductsModel(
          id: document.id,
          brandModel: BrandModel.fromJson(json["brand"]),
          categoryId: json["categoryId"],
          currency: json["currency"],
          productImage: json["productImage"],
          productName: json["productName"],
          discount: json["discount"],
          price: json["price"],
          productSize: List<String>.from(json["productSize"]),
          stock: json["stock"],
        );
      }
    } catch (e) {
      log("EXCEPTION ProductsModel $e");
    }

    return productsModel;
  }
}
