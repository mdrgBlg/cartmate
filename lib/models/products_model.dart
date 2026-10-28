import '/models/brand_model.dart';

class ProductsModel {
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
    this.isWishlisted = false,
  });

  factory ProductsModel.fromDocument({
    required String id,
    required Map<String, dynamic> json,
  }) => ProductsModel(
    id: id,
    brandModel: BrandModel.fromJsonDb(json["brand"] as Map<String, dynamic>),
    categoryId: json["categoryId"] as String,
    currency: json["currency"] as String,
    productImageList: (json["productImage"] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    productName: json["productName"] as String,
    discount: (json["discount"] as num).toInt(),
    price: (json["price"] as num).toInt(),
    productSize: (json["productSize"] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    stock: (json["stock"] as num).toInt(),
  );

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
    id: json["id"] as String,
    brandModel: BrandModel.fromJsonDb(json["brand"] as Map<String, dynamic>),
    categoryId: json["categoryId"] as String,
    currency: json["currency"] as String,
    productImageList: (json["productImage"] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    productName: json["productName"] as String,
    discount: (json["discount"] as num).toInt(),
    price: (json["price"] as num).toInt(),
    productSize: (json["productSize"] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    stock: (json["stock"] as num).toInt(),
  );

  factory ProductsModel.fromDb(
    Map<String, dynamic> json,
    BrandModel? brandModel,
  ) => ProductsModel(
    id: json['id'] as String,
    brandModel: brandModel,
    categoryId: json['categoryId'] as String,
    currency: json['currency'] as String,
    productImageList: (json['productImage'] as String).split(
      ',',
    ), // Split comma-separated string
    productName: json['productName'] as String,
    discount: json['discount'] as int,
    price: json['price'] as int,
    productSize: (json['productSize'] as String).split(
      ',',
    ), // Split comma-separated string
    stock: json['stock'] as int,
    isWishlisted: json['wishlist'] as int == 1,
  );

  final String id;
  final BrandModel? brandModel;
  final String categoryId;
  final String currency;
  final List<String> productImageList;
  final String productName;
  final int discount;
  final int price;
  final List<String>? productSize;
  final int stock;
  final bool isWishlisted;

  double get getPriceWithDiscount => price - price * (discount / 100);

  ProductsModel copyWith({bool? isWishlisted}) => ProductsModel(
    id: id,
    brandModel: brandModel,
    categoryId: categoryId,
    currency: currency,
    productImageList: productImageList,
    productName: productName,
    discount: discount,
    price: price,
    productSize: productSize,
    stock: stock,
    isWishlisted: isWishlisted ?? this.isWishlisted,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'brand': brandModel != null ? brandModel!.brandToMap() : null,
      'categoryId': categoryId,
      'currency': currency,
      'productImage': productImageList,
      'productName': productName,
      'discount': discount,
      'price': price,
      'productSize': productSize,
      'stock': stock,
    };
  }
}
