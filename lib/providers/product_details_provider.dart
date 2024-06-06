import 'package:flutter/foundation.dart';

class ProductDetailsProvider with ChangeNotifier {
  int selectedImage = 0;
  String? selectedSize;

  void changeSelectedImage(int value) {
    selectedImage = value;
    notifyListeners();
  }

  void changeSelectedSize(String value) {
    if (value == selectedSize) {
      selectedSize = null;
    } else {
      selectedSize = value;
    }

    notifyListeners();
  }
}
