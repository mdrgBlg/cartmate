import 'package:flutter/foundation.dart';

import '/data/repositories/user_repository.dart';
import '/models/cart_model.dart';
import '/models/user_info_model.dart';

class MainProvider with ChangeNotifier {
  MainProvider({required UserRepository userRepository})
    : _userRepository = userRepository;

  final UserRepository _userRepository;

  int get cartProductNumber => cartProducts.length;
  UserInfoModel? get userInfoModel => _userRepository.currentUser;

  double get checkoutPrice => cartProducts.fold(
    0,
    (sum, item) =>
        sum +
        item.quantity *
            (item.productModel.price -
                item.productModel.price * (item.productModel.discount / 100)),
  );

  List<CartModel> cartProducts = [];

  void addProductToCart(CartModel cartModel) {
    bool elementExists = false;

    for (var e in cartProducts) {
      if (e.productModel.id == cartModel.productModel.id &&
          e.size == cartModel.size) {
        ++e.quantity;
        elementExists = true;
        break;
      }
    }

    if (!elementExists) {
      cartProducts.add(cartModel);
    }

    notifyListeners();
  }

  void removeProductFromCart(CartModel cartModel) {
    int? indexToRemove;
    for (int i = 0; i < cartProducts.length; i++) {
      if (cartProducts[i].productModel.id == cartModel.productModel.id &&
          cartProducts[i].size == cartModel.size) {
        --cartProducts[i].quantity;
        if (cartProducts[i].quantity == 0) {
          indexToRemove = i;
        }
        break;
      }
    }
    if (indexToRemove != null) {
      cartProducts.removeAt(indexToRemove);
    }
    notifyListeners();
  }

  void checkoutSuccessful() {
    cartProducts.clear();
    notifyListeners();
  }

  /// In-memory only; SQLite tables are not touched.
  void clearSession() {
    _userRepository.clearCurrentUser();
    cartProducts.clear();
    notifyListeners();
  }
}
