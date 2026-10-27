import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '/models/checkout_model.dart';
import '/utils/constants/firebase_collection_constants.dart';
import '../models/result.dart';
import 'firebase_service.dart';

class OrderService {
  OrderService({required FirebaseService firebaseService})
    : _firebaseService = firebaseService;

  final FirebaseService _firebaseService;

  CollectionReference<Map<String, dynamic>> _orders(String userId) =>
      _firebaseService.firestore
          .collection(FirebaseCollectionConstants.usersCollection)
          .doc(userId)
          .collection(FirebaseCollectionConstants.ordersCollection);

  Future<Result<void>> saveOrder(CheckoutModel order) async {
    try {
      final ref = _orders(order.userId).doc();
      await ref.set({...order.toMap(), 'orderId': ref.id});
      return const Success<void>(null);
    } on FirebaseException catch (e) {
      log("FirebaseException saveOrder: $e");
      return Failure(Exception(e));
    } catch (e) {
      log("Exception saveOrder: $e");
      return Failure(Exception(e));
    }
  }

  Future<Result<List<CheckoutModel>>> fetchOrders(String userId) async {
    try {
      final response = await _orders(
        userId,
      ).orderBy('orderDate', descending: true).get();
      return Success(
        response.docs.map((e) => CheckoutModel.fromJson(e.data())).toList(),
      );
    } on FirebaseException catch (e) {
      log("FirebaseException fetchOrders: $e");
      return Failure(Exception(e));
    } catch (e) {
      log("Exception fetchOrders: $e");
      return Failure(Exception(e));
    }
  }
}
