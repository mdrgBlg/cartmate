import 'package:e_commerce/constants/custom_icons.dart';

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
}
