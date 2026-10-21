import 'products_model.dart';

class CartModel {
  CartModel({
    required this.productModel,
    required this.size,
    this.quantity = 1,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    productModel: ProductsModel.fromJson(
      json["product"] as Map<String, dynamic>,
    ),
    size: json["size"] as String,
    quantity: (json["quantity"] as num?)?.toInt() ?? 1,
  );

  final ProductsModel productModel;
  final String size;
  int quantity;

  String get getTotalPricerWithCurrency =>
      "${(productModel.getPriceWithDiscount * quantity)} ${productModel.currency}";

  Map<String, dynamic> toMap() {
    return {
      'product': productModel.toMap(),
      'size': size,
      'quantity': quantity,
    };
  }
}
