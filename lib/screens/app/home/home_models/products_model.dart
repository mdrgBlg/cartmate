import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '/models/brand_model.dart';

class ProductsModel {
  final String id;
  final BrandModel? brandModel;
  final String categoryId;
  final String currency;
  List<String> productImageList;
  final String productName;
  final int discount;
  final int price;
  final List<String>? productSize;
  final int stock;
  bool whishlist;

  ProductsModel({
    required this.id,
    required this.brandModel,
    required this.categoryId,
    required this.currency,
    required this.productImageList,
    required this.productName,
    required this.discount,
    required this.price,
    required this.productSize,
    required this.stock,
    this.whishlist = false,
  });

  static Future<ProductsModel?> fromDocument(
      DocumentSnapshot<Map<String, dynamic>> document) async {
    final json = document.data();
    ProductsModel? productsModel;
    try {
      if (json != null) {
        productsModel = ProductsModel(
          id: document.id,
          brandModel: await BrandModel.fromJson(json["brand"]),
          categoryId: json["categoryId"],
          currency: json["currency"],
          productImageList: List<String>.from(json["productImage"]),
          productName: json["productName"],
          discount: json["discount"],
          price: json["price"],
          productSize: json["productSize"] != null
              ? List<String>.from(json["productSize"])
              : null,
          stock: json["stock"],
        );
      }
    } catch (e) {
      log("EXCEPTION ProductsModel $e");
    }

    return productsModel;
  }

  static ProductsModel? fromJson(Map<String, dynamic> json) {
    ProductsModel? productsModel;
    try {
      productsModel = ProductsModel(
        id: json["id"],
        brandModel: BrandModel.fromJsonDb(json["brand"]),
        categoryId: json["categoryId"],
        currency: json["currency"],
        productImageList: List<String>.from(json["productImage"]),
        productName: json["productName"],
        discount: json["discount"],
        price: json["price"],
        productSize: json["productSize"],
        stock: json["stock"],
      );
    } catch (e) {
      log("EXCEPTION ProductsModel $e");
    }

    return productsModel;
  }

  static ProductsModel? fromDb(
      Map<String, dynamic> json, BrandModel? brandModel) {
    ProductsModel? productsModel;
    try {
      productsModel = ProductsModel(
          id: json['id'] as String,
          brandModel: brandModel,
          categoryId: json['categoryId'] as String,
          currency: json['currency'] as String,
          productImageList: (json['productImage'] as String)
              .split(','), // Split comma-separated string
          productName: json['productName'] as String,
          discount: json['discount'] as int,
          price: json['price'] as int,
          productSize: (json['productSize'] as String)
              .split(','), // Split comma-separated string
          stock: json['stock'] as int,
          whishlist: json['wishlist'] as int == 1 ? true : false);
    } catch (e) {
      log("EXCEPTION ProductsModel $e");
    }

    return productsModel;
  }

  static Map<String, dynamic> productToMap(ProductsModel product) {
    return {
      'id': product.id,
      'brandId': product.brandModel?.id,
      'categoryId': product.categoryId,
      'currency': product.currency,
      'productImage': product.productImageList.join(','),
      'productName': product.productName,
      'discount': product.discount,
      'price': product.price,
      'productSize':
          product.productSize != null ? product.productSize!.join(',') : "",
      'stock': product.stock,
      'wishlist': product.whishlist ? 1 : 0,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'brand': brandModel != null ? BrandModel.brandToMap(brandModel!) : null,
      'categoryId': categoryId,
      'currency': currency,
      'productImage': productImageList,
      'productName': productName,
      'discount': discount,
      'price': price,
      'stock': stock,
    };
  }

  ProductsModel.copy(ProductsModel other)
      : id = other.id,
        brandModel = other.brandModel,
        categoryId = other.categoryId,
        currency = other.currency,
        productImageList = List<String>.from(other.productImageList),
        productName = other.productName,
        discount = other.discount,
        price = other.price,
        productSize = List<String>.from(
            other.productSize != null ? other.productSize! : []),
        stock = other.stock,
        whishlist = other.whishlist;
}
