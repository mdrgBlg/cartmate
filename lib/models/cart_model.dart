import 'dart:developer';

import '/screens/app/home/home_models/products_model.dart';

class CartModel {
  final ProductsModel productModel;
  final String size;
  int quantity;

  CartModel({
    required this.productModel,
    required this.size,
    this.quantity = 1,
  });

  static CartModel? fromJson(Map<String, dynamic> json) {
    CartModel? cartModel;
    try {
      cartModel = CartModel(
        productModel: ProductsModel.fromJson(json["product"])!,
        size: json["size"],
        quantity: json["quantity"] ?? 1,
      );
    } catch (e) {
      log("EXCEPTION CartModel $e");
    }
    return cartModel;
  }

  Map<String, dynamic> toMap() {
    return {
      'product': productModel.toMap(),
      'size': size,
      'quantity': quantity,
    };
  }
}
