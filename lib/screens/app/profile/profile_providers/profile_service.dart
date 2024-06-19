import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../checkout/checkout_models/checkout_model.dart';

class ProfileService {
  static Future<List<CheckoutModel>> fetchMyOrder(String userId) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    List<CheckoutModel> myOrderList = [];
    try {
      final response =
          await db.collection('Users').doc(userId).collection('Orders').get();
      if (response.docs.isNotEmpty) {
        for (var e in response.docs) {
          CheckoutModel? checkoutModel = CheckoutModel.fromDocument(e);
          if (checkoutModel != null) {
            myOrderList.add(checkoutModel);
          }
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
