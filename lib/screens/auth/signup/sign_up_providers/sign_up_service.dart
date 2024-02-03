import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/constants/constants.dart';
import '/models/user_info_model.dart';
import '/models/response_model.dart';

class SignUpService {
  static Future<(String?, String?)> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await Constants.firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        return (userCredential.user!.uid, null);
      }
    } on FirebaseAuthException catch (e) {
      log("FirebaseAuthException sign up: $e");
      return (null, e.message);
    } catch (e) {
      log("Exception signUp: $e");
    }
    return (null, "Something went wrong. Please try again");
  }

  static Future<ResponseModel> saveUserData(UserInfoModel userInfoModel) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    try {
      await db.collection("Users").doc(userInfoModel.id).set(UserInfoModel.toJson(userInfoModel));
      return ResponseModel(success: true);
    } on FirebaseException catch (e) {
      log("FirebaseException saveUserData: $e");
      return ResponseModel(success: false, error: e.message);
    } catch (e) {
      log("Exception saveUserData: $e");
      return ResponseModel(success: false, error: "Something went wrong. Please try again");
    }
  }
}
