import 'package:e_commerce/constants/custom_images.dart';
import 'package:flutter/foundation.dart';

class ProductDetailsProvider with ChangeNotifier {
  int selectedImage = 0;
  int? selectedSize;

  void changeSelectedImage(int value) {
    selectedImage = value;
    notifyListeners();
  }

  void changeSelectedSize(int value) {
    if (value == selectedSize) {
      selectedSize = null;
    } else {
      selectedSize = value;
    }

    notifyListeners();
  }
}
