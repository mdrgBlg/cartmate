import 'dart:developer';

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
}
