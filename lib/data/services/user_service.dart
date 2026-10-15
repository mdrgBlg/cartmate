import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '/models/user_info_model.dart';
import '../models/result.dart';
import 'firebase_service.dart';

class UserService {
  UserService({required FirebaseService firebaseService})
    : _firebaseService = firebaseService;

  static const _usersCollection = 'Users';

  final FirebaseService _firebaseService;

  CollectionReference<Map<String, dynamic>> _users() =>
      _firebaseService.firestore.collection(_usersCollection);

  Future<Result<void>> saveUserData(UserInfoModel user) async {
    try {
      await _users().doc(user.id).set(UserInfoModel.toJson(user));
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
}
