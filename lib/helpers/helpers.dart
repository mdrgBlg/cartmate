import '/constants/custom_icons.dart';
import '/constants/custom_images.dart';
import '/models/brand_model.dart';
import '/screens/app/home/home_models/products_model.dart';

class Helpers {
  static String fetchIcon(String? iconName) {
    switch (iconName) {
      case "clothes":
        return CustomIcons.clothes;
      case "furniture":
        return CustomIcons.furniture;
      case "animals":
        return CustomIcons.animals;
      case "electronics":
        return CustomIcons.electronics;
      case "shoes":
        return CustomIcons.shoes;
      case "sports":
        return CustomIcons.sports;
      default:
        return CustomIcons.sports;
    }
  }

  static List<String> fetchImages(String? productName) {
    switch (productName) {
      case "supernova":
        return CustomImages.supernova;

      default:
        return CustomImages.supernova;
    }
  }

  static List<ProductsModel> getBrandProducts(List<ProductsModel> productsList, BrandModel brand) {
    List<ProductsModel> filteredProductsList = [];
    for (var e in productsList) {
      if (e.brandModel != null && e.brandModel!.id == brand.id) {
        filteredProductsList.add(e);
      }
    }
    return filteredProductsList;
  }
}
