import 'assets/custom_icons.dart';
import 'assets/custom_images.dart';
import 'global_enums.dart';

String fetchIcon(String? iconName) {
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

String fetchImage(String? categoryName) {
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

OrderStatus? getStatusOnIndex(int index) => switch (index) {
  0 => OrderStatus.pending,
  1 => OrderStatus.processing,
  2 => OrderStatus.inTransit,
  3 => OrderStatus.delivered,
  _ => null,
};
