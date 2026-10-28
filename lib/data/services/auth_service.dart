import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import '../models/auth_exception.dart';
import '../models/result.dart';
import 'firebase_service.dart';

class AuthService {
  AuthService({required FirebaseService firebaseService})
    : _firebaseService = firebaseService;

  final FirebaseService _firebaseService;

  FirebaseAuth get _auth => _firebaseService.auth;

  Stream<String?> authStateChanges() =>
      _auth.authStateChanges().map((user) => user?.uid);

  Future<Result<String>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user == null) {
        return const Failure(AuthException(AuthErrorType.unknown));
      }
      return Success(user.uid);
    } on FirebaseAuthException catch (e) {
      log("FirebaseAuthException signIn: $e");
      var type = _mapFirebaseAuthException(e);
      // Do not reveal whether an account exists for this email.
      if (type == AuthErrorType.userNotFound) {
        type = AuthErrorType.invalidCredentials;
      }
      return Failure(AuthException(type, cause: e));
    } catch (e) {
      log("Exception signIn: $e");
      return Failure(Exception(e));
    }
  }

  Future<Result<String>> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user == null) {
        return const Failure(AuthException(AuthErrorType.unknown));
      }
      return Success(user.uid);
    } on FirebaseAuthException catch (e) {
      log("FirebaseAuthException signUp: $e");
      return Failure(AuthException(_mapFirebaseAuthException(e), cause: e));
    } catch (e) {
      log("Exception signUp: $e");
      return Failure(Exception(e));
    }
  }

  Future<Result<void>> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return const Success<void>(null);
    } on FirebaseAuthException catch (e) {
      log("FirebaseAuthException sendPasswordResetEmail: $e");
      return Failure(AuthException(_mapFirebaseAuthException(e), cause: e));
    } catch (e) {
      log("Exception sendPasswordResetEmail: $e");
      return Failure(Exception(e));
    }
  }

  Future<Result<void>> signOut() async {
    try {
      await _auth.signOut();
      return const Success<void>(null);
    } on FirebaseAuthException catch (e) {
      log("FirebaseAuthException signOut: $e");
      return Failure(AuthException(_mapFirebaseAuthException(e), cause: e));
    } catch (e) {
      log("Exception signOut: $e");
      return Failure(Exception(e));
    }
  }

  /// Used only to roll back a freshly created account during sign-up.
  Future<Result<void>> deleteCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return const Failure(AuthException(AuthErrorType.unknown));
      }
      await user.delete();
      return const Success<void>(null);
    } on FirebaseAuthException catch (e) {
      log("FirebaseAuthException deleteCurrentUser: $e");
      return Failure(AuthException(_mapFirebaseAuthException(e), cause: e));
    } catch (e) {
      log("Exception deleteCurrentUser: $e");
      return Failure(Exception(e));
    }
  }

  AuthErrorType _mapFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
      case 'missing-email':
        return AuthErrorType.invalidEmail;
      case 'invalid-credential':
      case 'wrong-password':
        return AuthErrorType.invalidCredentials;
      case 'user-not-found':
        return AuthErrorType.userNotFound;
      case 'user-disabled':
        return AuthErrorType.userDisabled;
      case 'email-already-in-use':
        return AuthErrorType.emailAlreadyInUse;
      case 'weak-password':
        return AuthErrorType.weakPassword;
      case 'too-many-requests':
        return AuthErrorType.tooManyRequests;
      case 'network-request-failed':
        return AuthErrorType.networkError;
      case 'operation-not-allowed':
        return AuthErrorType.operationNotAllowed;
      default:
        return AuthErrorType.unknown;
    }
  }
}
