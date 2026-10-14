import 'package:e_commerce/helpers/helpers.dart';

class CategoriesModel {
  CategoriesModel({
    required this.id,
    required this.categoryName,
    required this.iconName,
    required this.isFeatured,
    required this.parentId,
  });

  factory CategoriesModel.fromDocument({
    required String id,
    required Map<String, dynamic> json,
  }) => CategoriesModel(
    id: id,
    categoryName: json["categoryName"] as String,
    iconName: Helpers.fetchIcon(json["iconName"] as String?),
    isFeatured: json["isFeatured"] as bool,
    parentId: json["parentId"] as String?,
  );

  final String id;
  final String categoryName;
  final String iconName;
  final bool isFeatured;
  final String? parentId;
}
