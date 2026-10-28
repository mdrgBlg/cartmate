import 'dart:developer';

import 'package:flutter/foundation.dart';

import '/data/models/result.dart';
import '/data/repositories/auth_repository.dart';
import '/data/repositories/cart_repository.dart';
import '/data/repositories/user_repository.dart';
import '/data/models/user_info_model.dart';

class WelcomeProvider with ChangeNotifier {
  WelcomeProvider({
    required AuthRepository authRepository,
    required CartRepository cartRepository,
    required UserRepository userRepository,
  }) : _authRepository = authRepository,
       _cartRepository = cartRepository,
       _userRepository = userRepository {
    _sessionFuture = _restoreSession();
  }

  final AuthRepository _authRepository;
  final CartRepository _cartRepository;
  final UserRepository _userRepository;

  late Future<Result<UserInfoModel>?> _sessionFuture;

  /// Null when there is no persisted session to restore.
  Future<Result<UserInfoModel>?> get sessionFuture => _sessionFuture;

  /// Loads the profile for the current Firebase session. On failure the
  /// session is signed out.
  Future<Result<UserInfoModel>?> _restoreSession() async {
    final userId = _authRepository.currentUserId;

    if (userId == null) {
      return null;
    }

    final result = await _userRepository.fetchUserInfo(userId);
    if (result is Failure<UserInfoModel>) {
      final signOutResult = await _authRepository.signOut();
      log("restoreSession failed, sign-out result: $signOutResult");
    }
    if (result is Success<UserInfoModel>) {
      // A failed cart load must not block the login; home opens with an empty cart.
      final cartResult = await _cartRepository.loadCart();
      if (cartResult is Failure<void>) {
        log("restoreSession cart load failed: $cartResult");
      }
    }
    return result;
  }
}
