import 'products_model.dart';

class CartModel {
  CartModel({
    required this.productModel,
    required this.size,
    this.quantity = 1,
    String? currency,
  }) : id = '${productModel.id}:$size',
       currency = currency ?? productModel.currency;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    productModel: ProductsModel.fromJson(
      json["product"] as Map<String, dynamic>,
    ),
    size: json["size"] as String,
    quantity: (json["quantity"] as num?)?.toInt() ?? 1,
    currency: json["currency"] as String?,
  );

  /// Derived from product id and size so the same product/size always maps
  /// to the same cart line.
  final String id;
  final ProductsModel productModel;
  final String size;
  final String currency;
  final int quantity;

  double get getTotalPrice => productModel.getPriceWithDiscount * quantity;

  String get getTotalPriceWithCurrency =>
      "${(productModel.getPriceWithDiscount * quantity)} $currency";

  CartModel copyWith({int? quantity}) => CartModel(
    productModel: productModel,
    size: size,
    quantity: quantity ?? this.quantity,
    currency: currency,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product': productModel.toMap(),
      'size': size,
      'quantity': quantity,
      'currency': currency,
    };
  }
}
