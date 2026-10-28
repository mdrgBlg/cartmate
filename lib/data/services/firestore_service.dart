import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '/data/models/brand_model.dart';
import '/data/models/categories_model.dart';
import '/data/models/products_model.dart';
import '/data/models/user_info_model.dart';
import '/utils/constants/firebase_collection_constants.dart';
import '/utils/firestore_logger.dart';
import '/utils/global_enums.dart';
import '../models/result.dart';
import 'firebase_service.dart';

class FirestoreService {
  FirestoreService({required FirebaseService firebaseService})
    : _firebaseService = firebaseService;

  final FirebaseService _firebaseService;

  CollectionReference<Map<String, dynamic>> _users() => _firebaseService
      .firestore
      .collection(FirebaseCollectionConstants.usersCollection);

  Future<Result<void>> saveUserData(UserInfoModel user) async {
    try {
      final ref = _users().doc(user.id);
      final data = user.toJson();
      await FirestoreLogger.traceWrite(
        'saveUserData',
        'SET',
        ref.path,
        () => ref.set(data),
        request: data,
      );
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
      final ref = _users().doc(userId);
      final response = await FirestoreLogger.traceDoc(
        'fetchUserInfo',
        ref.path,
        ref.get,
      );
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
      final ref = _users().doc(userId);
      await FirestoreLogger.traceWrite(
        methodName,
        'UPDATE',
        ref.path,
        () => ref.update(fields),
        request: fields,
      );
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

  Future<Result<List<ProductsModel>>> fetchProducts() async {
    try {
      final collection = _firebaseService.firestore.collection(
        FirebaseCollectionConstants.productsCollection,
      );
      final response = await FirestoreLogger.traceQuery(
        'fetchProducts',
        collection.path,
        collection.get,
      );
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
      final collection = _firebaseService.firestore.collection(
        FirebaseCollectionConstants.categoriesCollection,
      );
      final response = await FirestoreLogger.traceQuery(
        'fetchCategories',
        collection.path,
        collection.get,
      );
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
      final collection = _firebaseService.firestore.collection(
        FirebaseCollectionConstants.brandsCollection,
      );
      final response = await FirestoreLogger.traceQuery(
        'fetchBrands',
        collection.path,
        collection.get,
      );
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
