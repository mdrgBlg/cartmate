import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '/db/db_constants.dart';
import '/db/db_helper.dart';
import '/db/db_service.dart';
import '/models/brand_model.dart';
import '/models/response_model.dart';
import '/models/user_info_model.dart';
import '/screens/app/home/home_models/products_model.dart';
import '/screens/app/home/home_providers/home_service.dart';

class MainProvider with ChangeNotifier {
  List<ProductsModel> whishlistProductsList = [];
  int cartProductNumber = 0;
  UserInfoModel? userInfoModel;

  final collection = FirebaseFirestore.instance.collection('Users');

  void wishlistFlagChange(ProductsModel productsModel) {
    productsModel.whishlist = !productsModel.whishlist;
    if (productsModel.whishlist) {
      whishlistProductsList.add(productsModel);
    } else {
      whishlistProductsList
          .removeWhere((element) => element.id == productsModel.id);
    }
    notifyListeners();
  }

  Future<bool> changeUserName(String firstName, String lastName) async {
    bool success = false;
    userInfoModel?.firstName = firstName;
    userInfoModel?.lastName = lastName;
    await collection.doc(userInfoModel?.id).update({
      'firstName': firstName,
      'lastName': lastName,
    }).then((value) {
      success = true;
    }).catchError((onError) {
      success = false;
    });

    notifyListeners();
    return success;
  }

  Future<bool> changeEmail(String value) async {
    bool success = false;
    userInfoModel?.email = value;
    await collection.doc(userInfoModel?.id).update({
      'email': value,
    }).then((value) {
      success = true;
    }).catchError((onError) {
      success = false;
    });
    notifyListeners();
    return success;
  }

  Future<bool> changeUsername(String value) async {
    bool success = false;

    userInfoModel?.username = value;
    await collection.doc(userInfoModel?.id).update({
      'username': value,
    }).then((value) {
      success = true;
    }).catchError((onError) {
      success = false;
    });
    notifyListeners();
    return success;
  }

  Future<bool> changeUserPhoneNumber(String value) async {
    bool success = false;
    userInfoModel?.phoneNumber = value;
    await collection.doc(userInfoModel?.id).update({
      'phoneNumber': value,
    }).then((value) {
      success = true;
    }).catchError((onError) {
      success = false;
    });
    notifyListeners();
    return success;
  }

  Future<bool> changeGender(String? value) async {
    bool success = false;
    userInfoModel?.gender = value ?? "";
    await collection.doc(userInfoModel?.id).update({
      'gender': value == "Male" ? true : false,
    }).then((value) {
      success = true;
    }).catchError((onError) {
      success = false;
    });
    notifyListeners();
    return success;
  }

  Future<bool> changeDateOfBirth(String? value) async {
    bool success = false;
    userInfoModel?.dateOfBirth = value ?? "";
    await collection.doc(userInfoModel?.id).update({
      'dateOfBirth': value,
    }).then((value) {
      success = true;
    }).catchError((onError) {
      success = false;
    });
    notifyListeners();
    return success;
  }

  Future<ResponseModel> fetchUserInfo(String userId) async {
    try {
      final response = await collection.doc(userId).get();
      if (response.data() != null) {
        userInfoModel = UserInfoModel.fromJson(response.data()!);
        // await fetchWhishlistProducts();
        return ResponseModel(success: true);
      }
      log("This user doesn't exist");
      return ResponseModel(success: false);
    } on FirebaseException catch (e) {
      log("FirebaseException fetchUserInfo: $e");
      return ResponseModel(success: false);
    } catch (e) {
      log("Exception fetchUserInfo: $e");
    }

    return ResponseModel(success: false);
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
          BrandModel.brandToMap(productsModel.brandModel!),
        );
      } else {
        brandInserted = true;
      }
    }
    if (brandInserted) {
      return await HomeService.addProductToWhishlist(
        ProductsModel.productToMap(productsModel),
      );
    } else {
      return false;
    }
  }

  Future<void> removeProductFromWhishlist(ProductsModel productsModel) async {
    Database db = await DbHelper.database;
    await db.delete(DbConstants.whishlistTable,
        where: 'id = ?', whereArgs: [productsModel.id]);
  }
}
