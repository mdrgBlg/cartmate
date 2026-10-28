import 'dart:developer';

import '/data/services/api_service.dart';
import '/data/models/user_info_model.dart';
import '/utils/global_enums.dart';
import '../models/result.dart';
import '../services/auth_service.dart';
import '../services/firebase_service.dart';

class AuthRepository {
  AuthRepository({
    required FirebaseService firebaseService,
    required AuthService authService,
    required ApiService apiService,
  }) : _firebaseService = firebaseService,
       _authService = authService,
       _apiService = apiService;

  final FirebaseService _firebaseService;
  final AuthService _authService;
  final ApiService _apiService;

  String? get currentUserId => _firebaseService.auth.currentUser?.uid;

  /// Signs in and loads the user's profile. If the profile cannot be loaded
  /// the session is signed out again, so a signed-in session always has a
  /// loaded profile.
  Future<Result<UserInfoModel>> login({
    required String email,
    required String password,
  }) async {
    final signInResult = await _authService.signIn(
      email: email,
      password: password,
    );
    switch (signInResult) {
      case Failure(:final exception):
        return Failure(exception);
      case Success(data: final uid):
        final fetchResult = await _apiService.fetchUserInfo(uid);
        if (fetchResult is Failure<UserInfoModel>) {
          final signOutResult = await _authService.signOut();
          log("Login profile fetch failed, sign-out result: $signOutResult");
        }
        return fetchResult;
    }
  }

  /// Creates the account and writes the profile. If the profile write fails
  /// the new account is deleted (fallback: signed out) and the original
  /// failure is returned.
  Future<Result<UserInfoModel>> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String username,
    required String phoneNumber,
    required DateTime dateOfBirth,
    required Gender gender,
  }) async {
    final signUpResult = await _authService.signUp(
      email: email,
      password: password,
    );
    switch (signUpResult) {
      case Failure(:final exception):
        return Failure(exception);
      case Success(data: final uid):
        final user = UserInfoModel(
          id: uid,
          firstName: firstName,
          lastName: lastName,
          email: email,
          username: username,
          phoneNumber: phoneNumber,
          dateOfBirth: dateOfBirth,
          gender: gender,
        );
        final saveResult = await _apiService.saveUserData(user);
        switch (saveResult) {
          case Success():
            return Success(user);
          case Failure(:final exception):
            log("Sign-up profile save failed: $exception");
            await _rollbackSignUp();
            return Failure(exception);
        }
    }
  }

  Future<Result<void>> sendPasswordResetEmail(String email) =>
      _authService.sendPasswordResetEmail(email);

  Future<Result<void>> signOut() => _authService.signOut();

  Future<void> _rollbackSignUp() async {
    final deleteResult = await _authService.deleteCurrentUser();
    if (deleteResult is Success<void>) {
      log("Sign-up rollback: new user deleted");
      return;
    }
    final signOutResult = await _authService.signOut();
    log("Sign-up rollback: delete failed, sign-out result: $signOutResult");
  }
}
