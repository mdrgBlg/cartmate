import 'dart:developer';

import '/screens/app/home/home_models/products_model.dart';

class CartModel {
  final ProductsModel? productModel;
  final String size;

  CartModel({
    required this.productModel,
    required this.size,
  });

  static CartModel? fromJson(Map<String, dynamic> json) {
    CartModel? cartModel;
    try {
      cartModel = CartModel(
        productModel: ProductsModel.fromJson(json["product"]),
        size: json["size"],
      );
    } catch (e) {
      log("EXCEPTION CartModel $e");
    }
    return cartModel;
  }

  Map<String, dynamic> toMap() {
    return {
      'product': productModel?.toMap(),
      'size': size,
    };
  }
}
