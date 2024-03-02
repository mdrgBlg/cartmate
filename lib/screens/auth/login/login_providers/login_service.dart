import 'dart:developer';

import 'package:e_commerce/models/response_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/constants/constants.dart';

class LoginService {
  static Future<(String?, String?)> login(String email, String password) async {
    try {
      final userCredential = await Constants.firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        return (userCredential.user!.uid, null);
      }
    } on FirebaseAuthException catch (e) {
      log("FirebaseAuthException login: $e");
      return (null, e.message);
    } catch (e) {
      log("Exception login: $e");
    }
    return (null, "Something went wrong. Please try again");
  }

  static Future<ResponseModel> forgetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );

      return ResponseModel(success: true);
    } on FirebaseAuthException catch (e) {
      log("FirebaseAuthException forgetPassword: $e");
      return ResponseModel(success: false, error: e.message);
    } catch (e) {
      log("Exception forgetPassword: $e");
    }
    return ResponseModel(
      success: false,
      error: "Something went wrong. Please try again",
    );
  }
}
