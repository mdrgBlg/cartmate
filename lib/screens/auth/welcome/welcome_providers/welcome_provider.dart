import 'dart:developer';

import 'package:flutter/foundation.dart';

import '/data/models/result.dart';
import '/data/repositories/auth_repository.dart';
import '/data/repositories/user_repository.dart';
import '/models/user_info_model.dart';

class WelcomeProvider with ChangeNotifier {
  WelcomeProvider({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  }) : _authRepository = authRepository,
       _userRepository = userRepository {
    final userId = _authRepository.currentUserId;
    _sessionFuture = userId == null ? null : _restoreSession(userId);
  }

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  Future<Result<UserInfoModel>>? _sessionFuture;

  /// Null when there is no persisted session to restore.
  Future<Result<UserInfoModel>>? get sessionFuture => _sessionFuture;

  /// Loads the profile for the current Firebase session. On failure the
  /// session is signed out.
  Future<Result<UserInfoModel>> _restoreSession(String userId) async {
    final result = await _userRepository.fetchUserInfo(userId);
    if (result is Failure<UserInfoModel>) {
      final signOutResult = await _authRepository.signOut();
      log("restoreSession failed, sign-out result: $signOutResult");
    }
    return result;
  }
}
