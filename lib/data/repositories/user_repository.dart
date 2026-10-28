import 'package:flutter/material.dart';

import '/models/user_info_model.dart';
import '/utils/global_enums.dart';
import '../models/result.dart';
import '../services/api_service.dart';

class UserRepository with ChangeNotifier {
  UserRepository({required ApiService apiService}) : _apiService = apiService;

  final ApiService _apiService;

  UserInfoModel? _currentUser;

  UserInfoModel? get currentUser => _currentUser;

  void setCurrentUser(UserInfoModel? user) {
    _currentUser = user;
  }

  /// Writes remotely, then updates the cached current user on success.
  Future<Result<void>> updateName(String firstName, String lastName) async {
    final userId = _currentUser?.id;
    if (userId == null) {
      return Failure(Exception('No current user'));
    }

    final result = await _apiService.updateUserName(
      userId,
      firstName,
      lastName,
    );
    if (result case Success()) {
      _currentUser = _currentUser?.copyWith(
        firstName: firstName,
        lastName: lastName,
      );
      notifyListeners();
    }
    return result;
  }

  Future<Result<void>> updateUsername(String value) async {
    final userId = _currentUser?.id;
    if (userId == null) {
      return Failure(Exception('No current user'));
    }

    final result = await _apiService.updateUsername(userId, value);
    if (result case Success()) {
      _currentUser = _currentUser?.copyWith(username: value);
      notifyListeners();
    }
    return result;
  }

  Future<Result<void>> updatePhoneNumber(String value) async {
    final userId = _currentUser?.id;
    if (userId == null) {
      return Failure(Exception('No current user'));
    }

    final result = await _apiService.updatePhoneNumber(userId, value);
    if (result case Success()) {
      _currentUser = _currentUser?.copyWith(phoneNumber: value);
      notifyListeners();
    }
    return result;
  }

  Future<Result<void>> updateGender(Gender value) async {
    final userId = _currentUser?.id;
    if (userId == null) {
      return Failure(Exception('No current user'));
    }

    final result = await _apiService.updateGender(userId, value);
    if (result case Success()) {
      _currentUser = _currentUser?.copyWith(gender: value);
      notifyListeners();
    }
    return result;
  }

  Future<Result<void>> updateDateOfBirth(DateTime value) async {
    final userId = _currentUser?.id;
    if (userId == null) {
      return Failure(Exception('No current user'));
    }

    final result = await _apiService.updateDateOfBirth(userId, value);
    if (result case Success()) {
      _currentUser = _currentUser?.copyWith(dateOfBirth: value);
      notifyListeners();
    }
    return result;
  }

  /// In-memory only.
  void clearCurrentUser() {
    _currentUser = null;
  }

  /// Fetches the profile and caches it as the current user on success.
  Future<Result<UserInfoModel>> fetchUserInfo(String userId) async {
    final result = await _apiService.fetchUserInfo(userId);
    if (result case Success(:final data)) {
      _currentUser = data;
    }
    return result;
  }

  Future<Result<void>> saveUserData(UserInfoModel user) =>
      _apiService.saveUserData(user);
}
