import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '/models/brand_model.dart';
import '/screens/app/checkout/checkout_models/checkout_model.dart';
import '/screens/app/home/home_models/categories_model.dart';
import '/screens/app/home/home_models/products_model.dart';
import '/utils/global_enums.dart';
import '../../models/user_info_model.dart';
import '../models/result.dart';
import 'firebase_service.dart';

class ApiService {
  ApiService({required FirebaseService firebaseService})
    : _firebaseService = firebaseService;

  static const _usersCollection = 'Users';
  static const _ordersCollection = 'Orders';
  static const _productsCollection = 'Products';
  static const _categoriesCollection = 'Categories';
  static const _brandsCollection = 'Brands';

  final FirebaseService _firebaseService;

  CollectionReference<Map<String, dynamic>> _users() =>
      _firebaseService.firestore.collection(_usersCollection);

  Future<Result<void>> saveUserData(UserInfoModel user) async {
    try {
      await _users().doc(user.id).set(user.toJson());
      return const Success<void>(null);
    } on FirebaseException catch (e) {
      log("FirebaseException saveUserData: $e");
      return Failure(Exception(e));
    } catch (e) {
      log("Exception saveUserData: $e");
      return Failure(Exception(e));
    }
  }

  Future<Result<UserInfoModel>> fetchUserInfo(String userId) async {
    try {
      final response = await _users().doc(userId).get();
      final data = response.data();
      if (data == null) {
        log("This user doesn't exist");
        return Failure(Exception('User document not found'));
      }
      return Success(UserInfoModel.fromJson(data));
    } on FirebaseException catch (e) {
      log("FirebaseException fetchUserInfo: $e");
      return Failure(Exception(e));
    } catch (e) {
      log("Exception fetchUserInfo: $e");
      return Failure(Exception(e));
    }
  }

  Future<Result<void>> _updateUser(
    String userId,
    Map<String, dynamic> fields,
    String methodName,
  ) async {
    try {
      await _users().doc(userId).update(fields);
      return const Success<void>(null);
    } on FirebaseException catch (e) {
      log("FirebaseException $methodName: $e");
      return Failure(Exception(e));
    } catch (e) {
      log("Exception $methodName: $e");
      return Failure(Exception(e));
    }
  }

  Future<Result<void>> updateUserName(
    String userId,
    String firstName,
    String lastName,
  ) => _updateUser(userId, {
    'firstName': firstName,
    'lastName': lastName,
  }, 'updateUserName');

  Future<Result<void>> updateEmail(String userId, String value) =>
      _updateUser(userId, {'email': value}, 'updateEmail');

  Future<Result<void>> updateUsername(String userId, String value) =>
      _updateUser(userId, {'username': value}, 'updateUsername');

  Future<Result<void>> updatePhoneNumber(String userId, String value) =>
      _updateUser(userId, {'phoneNumber': value}, 'updatePhoneNumber');

  Future<Result<void>> updateGender(String userId, Gender value) =>
      _updateUser(userId, {'gender': value == Gender.male}, 'updateGender');

  Future<Result<void>> updateDateOfBirth(String userId, DateTime value) =>
      _updateUser(userId, {
        'dateOfBirth': value.toString(),
      }, 'updateDateOfBirth');

  Future<Result<List<CheckoutModel>>> fetchMyOrders(String userId) async {
    try {
      final response = await _users()
          .doc(userId)
          .collection(_ordersCollection)
          .get();
      return Success(
        response.docs.map((e) => CheckoutModel.fromJson(e.data())).toList(),
      );
    } on FirebaseException catch (e) {
      log("FirebaseException fetchMyOrders: $e");
      return Failure(Exception(e));
    } catch (e) {
      log("Exception fetchMyOrders: $e");
      return Failure(Exception(e));
    }
  }

  Future<Result<List<ProductsModel>>> fetchProducts() async {
    try {
      final response = await _firebaseService.firestore
          .collection(_productsCollection)
          .get();
      return Success(
        response.docs
            .map((e) => ProductsModel.fromDocument(id: e.id, json: e.data()))
            .toList(),
      );
    } on FirebaseException catch (e) {
      log("FirebaseException fetchProducts: $e");
      return Failure(Exception(e));
    } catch (e) {
      log("Exception fetchProducts: $e");
      return Failure(Exception(e));
    }
  }

  Future<Result<List<CategoriesModel>>> fetchCategories() async {
    try {
      final response = await _firebaseService.firestore
          .collection(_categoriesCollection)
          .get();
      return Success(
        response.docs
            .map((e) => CategoriesModel.fromDocument(id: e.id, json: e.data()))
            .where((category) => category.parentId == null)
            .toList(),
      );
    } on FirebaseException catch (e) {
      log("FirebaseException fetchCategories: $e");
      return Failure(Exception(e));
    } catch (e) {
      log("Exception fetchCategories: $e");
      return Failure(Exception(e));
    }
  }

  Future<Result<List<BrandModel>>> fetchBrands() async {
    try {
      final response = await _firebaseService.firestore
          .collection(_brandsCollection)
          .get();
      return Success(
        response.docs
            .map((e) => BrandModel.fromDocument(id: e.id, json: e.data()))
            .toList(),
      );
    } on FirebaseException catch (e) {
      log("FirebaseException fetchBrands: $e");
      return Failure(Exception(e));
    } catch (e) {
      log("Exception fetchBrands: $e");
      return Failure(Exception(e));
    }
  }
}
