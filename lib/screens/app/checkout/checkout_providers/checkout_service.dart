import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../checkout_models/checkout_model.dart';
import '/models/response_model.dart';

class CheckoutService {
  static Future<ResponseModel> orderProduct(
      CheckoutModel checkoutModel, String userId) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    try {
      await db.collection("Users").doc(userId).collection("Orders").add(
            checkoutModel.toMap(),
          );
      return ResponseModel(success: true);
    } on FirebaseException catch (e) {
      log("FirebaseException saveUserData: $e");
      return ResponseModel(success: false, error: e.message);
    } catch (e) {
      log("Exception saveUserData: $e");
      return ResponseModel(
          success: false, error: "Something went wrong. Please try again");
    }
  }
}
