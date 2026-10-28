import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '/data/models/products_model.dart';
import '/utils/constants/firebase_collection_constants.dart';
import '/utils/firestore_logger.dart';
import '../models/result.dart';
import 'firebase_service.dart';

class WishlistService {
  WishlistService({required FirebaseService firebaseService})
    : _firebaseService = firebaseService;

  final FirebaseService _firebaseService;

  static const firestoreLogger = FirestoreLogger();

  CollectionReference<Map<String, dynamic>>? _wishlist() {
    final userId = _firebaseService.auth.currentUser?.uid;
    if (userId == null) {
      return null;
    }
    return _firebaseService.firestore
        .collection(FirebaseCollectionConstants.usersCollection)
        .doc(userId)
        .collection(FirebaseCollectionConstants.wishlistCollection);
  }

  Future<Result<List<ProductsModel>>> fetchWishlistProducts() async {
    try {
      final wishlist = _wishlist();
      if (wishlist == null) {
        return Failure(Exception('No signed in user'));
      }
      final response = await firestoreLogger.traceQuery(
        'fetchWishlistProducts',
        wishlist.path,
        wishlist.get,
      );
      return Success(
        response.docs.map((e) => ProductsModel.fromJson(e.data())).toList(),
      );
    } on FirebaseException catch (e) {
      log("FirebaseException fetchWishlistProducts: $e");
      return Failure(Exception(e));
    } catch (e) {
      log("Exception fetchWishlistProducts: $e");
      return Failure(Exception(e));
    }
  }

  Future<Result<void>> addProduct(ProductsModel product) async {
    try {
      final wishlist = _wishlist();
      if (wishlist == null) {
        return Failure(Exception('No signed in user'));
      }
      final ref = wishlist.doc(product.id);
      final data = product.toMap();
      await firestoreLogger.traceWrite(
        'addProduct',
        'SET',
        ref.path,
        () => ref.set(data),
        request: data,
      );
      return const Success<void>(null);
    } on FirebaseException catch (e) {
      log("FirebaseException addProduct: $e");
      return Failure(Exception(e));
    } catch (e) {
      log("Exception addProduct: $e");
      return Failure(Exception(e));
    }
  }

  Future<Result<void>> removeProduct(String productId) async {
    try {
      final wishlist = _wishlist();
      if (wishlist == null) {
        return Failure(Exception('No signed in user'));
      }
      final ref = wishlist.doc(productId);
      await firestoreLogger.traceWrite(
        'removeProduct',
        'DELETE',
        ref.path,
        ref.delete,
      );
      return const Success<void>(null);
    } on FirebaseException catch (e) {
      log("FirebaseException removeProduct: $e");
      return Failure(Exception(e));
    } catch (e) {
      log("Exception removeProduct: $e");
      return Failure(Exception(e));
    }
  }
}
