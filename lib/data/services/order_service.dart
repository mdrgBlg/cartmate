import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '/data/models/checkout_model.dart';
import '/utils/constants/firebase_collection_constants.dart';
import '/utils/firestore_logger.dart';
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
      final Map<String, dynamic> data = {...order.toMap(), 'orderId': ref.id};
      await FirestoreLogger.traceWrite(
        'saveOrder',
        'SET',
        ref.path,
        () => ref.set(data),
        request: data,
      );
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
      final response = await FirestoreLogger.traceQuery(
        'fetchOrders',
        _orders(userId).path,
        () => _orders(userId).orderBy('orderDate', descending: true).get(),
      );
      final orders = <CheckoutModel>[];
      for (final doc in response.docs) {
        try {
          orders.add(CheckoutModel.fromJson(doc.data()));
        } catch (e, st) {
          FirestoreLogger.parseFailure(
            'fetchOrders',
            doc.id,
            doc.data(),
            e,
            st,
          );
          rethrow;
        }
      }
      return Success(orders);
    } on FirebaseException catch (e) {
      log("FirebaseException fetchOrders: $e");
      return Failure(Exception(e));
    } catch (e) {
      log("Exception fetchOrders: $e");
      return Failure(Exception(e));
    }
  }
}
