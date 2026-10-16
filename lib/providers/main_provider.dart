import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '/data/repositories/user_repository.dart';
import '/db/db_constants.dart';
import '/db/db_helper.dart';
import '/db/db_service.dart';
import '/models/cart_model.dart';
import '/models/user_info_model.dart';
import '/screens/app/home/home_models/products_model.dart';
import '/screens/app/home/home_providers/home_service.dart';

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

  List<ProductsModel> whishlistProductsList = [];
  List<ProductsModel> productsList = [];
  List<CartModel> cartProducts = [];

  void wishlistFlagChange(ProductsModel productsModel) {
    productsModel.whishlist = !productsModel.whishlist;
    if (productsModel.whishlist) {
      whishlistProductsList.add(productsModel);
    } else {
      whishlistProductsList.removeWhere(
        (element) => element.id == productsModel.id,
      );
    }
    notifyListeners();
  }

  void setWishlistFlag() {
    for (var e in productsList) {
      if (whishlistProductsList.any((element) => element.id == e.id)) {
        e.whishlist = true;
      }
    }
  }

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
    whishlistProductsList.clear();
    notifyListeners();
  }

  Future<void> fetchWhishlistProducts() async {
    whishlistProductsList = await HomeService.fetchWhishlistProducts();
  }

  Future<bool> addProductToWhishlist(ProductsModel productsModel) async {
    bool brandInserted = false;
    await DbService.whishlistTableExists();
    await DbService.brandTableExists();
    if (productsModel.brandModel != null) {
      // Check if brand exists (assuming you have a method to check)
      if (!await DbService.doesBrandExist(productsModel.brandModel!.id)) {
        // Insert brand if it doesn't exist
        brandInserted = await HomeService.addBrand(
          productsModel.brandModel!.brandToMap(),
        );
      } else {
        brandInserted = true;
      }
    }
    if (brandInserted) {
      return await HomeService.addProductToWhishlist(
        productsModel.productToMap(),
      );
    } else {
      return false;
    }
  }

  Future<void> removeProductFromWhishlist(ProductsModel productsModel) async {
    Database db = await DbHelper.database;
    await db.delete(
      DbConstants.whishlistTable,
      where: 'id = ?',
      whereArgs: [productsModel.id],
    );
  }

  Future<void> fetchProducts() async {
    productsList = await HomeService.fetchProducts();
    setWishlistFlag();
  }
}
