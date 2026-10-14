class BrandModel {
  BrandModel({
    required this.id,
    required this.brandName,
    required this.iconName,
    required this.productCount,
  });

  factory BrandModel.fromDocument({
    required String id,
    required Map<String, dynamic> json,
  }) => BrandModel(
    id: id,
    brandName: json["brandName"] as String,
    iconName: json["iconName"] as String,
    productCount: (json["productCount"] as num).toInt(),
  );

  factory BrandModel.fromJsonDb(Map<String, dynamic> json) => BrandModel(
    id: json["id"] as String,
    brandName: json["brandName"] as String,
    iconName: json["iconName"] as String,
    productCount: (json["productCount"] as num).toInt(),
  );

  final String id;
  final String brandName;
  String iconName;
  final int productCount;

  Map<String, dynamic> brandToMap() {
    return {
      'id': id,
      'brandName': brandName,
      'iconName': iconName,
      'productCount': productCount,
    };
  }
}
