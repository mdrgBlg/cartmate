import 'package:flutter/foundation.dart';

class ProductSizeProvider with ChangeNotifier {
  ProductSizeProvider({this.onChanged});

  final ValueChanged<String?>? onChanged;

  String? _selectedSize;
  String? get selectedSize => _selectedSize;

  void changeSelectedSize(String value) {
    _selectedSize = value == _selectedSize ? null : value;
    notifyListeners();
    onChanged?.call(_selectedSize);
  }
}
