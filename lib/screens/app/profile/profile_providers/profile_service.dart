import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '/utils/global_enums.dart';
import '../../checkout/checkout_models/checkout_model.dart';

class ProfileService {
  static final _users = FirebaseFirestore.instance.collection('Users');

  static Future<bool> updateUserName(
    String userId,
    String firstName,
    String lastName,
  ) async {
    bool success = false;
    await _users
        .doc(userId)
        .update({'firstName': firstName, 'lastName': lastName})
        .then((_) => success = true)
        .catchError((_) => success = false);
    return success;
  }

  static Future<bool> updateEmail(String userId, String value) async {
    bool success = false;
    await _users
        .doc(userId)
        .update({'email': value})
        .then((_) => success = true)
        .catchError((_) => success = false);
    return success;
  }

  static Future<bool> updateUsername(String userId, String value) async {
    bool success = false;
    await _users
        .doc(userId)
        .update({'username': value})
        .then((_) => success = true)
        .catchError((_) => success = false);
    return success;
  }

  static Future<bool> updatePhoneNumber(String userId, String value) async {
    bool success = false;
    await _users
        .doc(userId)
        .update({'phoneNumber': value})
        .then((_) => success = true)
        .catchError((_) => success = false);
    return success;
  }

  static Future<bool> updateGender(String userId, Gender? value) async {
    bool success = false;
    await _users
        .doc(userId)
        .update({'gender': value == Gender.male})
        .then((_) => success = true)
        .catchError((_) => success = false);
    return success;
  }

  static Future<bool> updateDateOfBirth(String userId, String? value) async {
    bool success = false;
    await _users
        .doc(userId)
        .update({'dateOfBirth': value})
        .then((_) => success = true)
        .catchError((_) => success = false);
    return success;
  }

  static Future<List<CheckoutModel>> fetchMyOrder(String userId) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    List<CheckoutModel> myOrderList = [];
    try {
      final response = await db
          .collection('Users')
          .doc(userId)
          .collection('Orders')
          .get();
      if (response.docs.isNotEmpty) {
        for (var e in response.docs) {
          final checkoutModel = CheckoutModel.fromJson(e.data());
          myOrderList.add(checkoutModel);
        }
      } else {
        log("This list is empty");
      }
    } on FirebaseException catch (e) {
      log("FirebaseException fetchMyOrder: $e");
    } catch (e) {
      log("Exception fetchMyOrder: $e");
    }
    return myOrderList;
  }
}
