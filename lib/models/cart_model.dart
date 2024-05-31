import '/screens/app/home/home_models/products_model.dart';

class CartModel {
  final ProductsModel productModel;
  final String size;

  CartModel({
    required this.productModel,
    required this.size,
  });
}
