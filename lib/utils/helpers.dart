import '/constants/custom_images.dart';
import '/constants/custom_icons.dart';
import '/models/brand_model.dart';
import '/screens/app/home/home_models/products_model.dart';

class Helpers {
  static String fetchIcon(String? iconName) {
    switch (iconName) {
      case "clothes":
        return CustomIcons.clothes;
      case "furniture":
        return CustomIcons.furniture;

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

  static String fetchImage(String? categoryName) {
    switch (categoryName?.toLowerCase()) {
      case "clothes":
        return CustomImages.clothesImage;
      case "furniture":
        return CustomImages.furnitureImage;
      case "electronics":
        return CustomImages.hpImage;
      case "shoes":
        return CustomImages.nike;
      case "sports":
        return CustomImages.sportsImage;
      default:
        return CustomIcons.sports;
    }
  }

  static List<ProductsModel> getBrandProducts(
      List<ProductsModel> productsList, BrandModel brand) {
    List<ProductsModel> filteredProductsList = [];
    for (var e in productsList) {
      if (e.brandModel != null && e.brandModel!.id == brand.id) {
        filteredProductsList.add(e);
      }
    }
    return filteredProductsList;
  }

  static const List<String> genders = ['Male', 'Female'];

  static double calculateDiscountPrice(int price, int discount) {
    return price - price * (discount / 100);
  }

  static String fetchOrderStatus(int value) {
    switch (value) {
      case 0:
        return "Pending";
      case 1:
        return "Processing";
      case 2:
        return "In Transit";
      case 3:
        return "Delivered";

      default:
        return "";
    }
  }
}
