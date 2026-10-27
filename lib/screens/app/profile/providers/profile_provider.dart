import 'package:flutter/material.dart';

import '/data/models/auth_exception.dart';
import '/data/models/result.dart';
import '/data/repositories/auth_repository.dart';
import '/data/repositories/cart_repository.dart';
import '/data/repositories/user_repository.dart';
import '/data/repositories/wishlist_repository.dart';
import '/models/user_info_model.dart';
import '/utils/extensions/exception_extension.dart';
import '/utils/global_enums.dart';

class ProfileProvider with ChangeNotifier {
  ProfileProvider({
    required AuthRepository authRepository,
    required CartRepository cartRepository,
    required UserRepository userRepository,
    required WishlistRepository wishlistRepository,
  }) : _authRepository = authRepository,
       _cartRepository = cartRepository,
       _userRepository = userRepository,
       _wishlistRepository = wishlistRepository {
    final userInfo = _userRepository.currentUser;

    firstNameController = TextEditingController(text: userInfo?.firstName);
    lastNameController = TextEditingController(text: userInfo?.lastName);
    usernameController = TextEditingController(text: userInfo?.username);
    phoneController = TextEditingController(text: userInfo?.phoneNumber);
  }

  final AuthRepository _authRepository;
  final CartRepository _cartRepository;
  final UserRepository _userRepository;
  final WishlistRepository _wishlistRepository;

  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController usernameController;
  late final TextEditingController phoneController;

  Exception? _error;
  bool get hasError => _error != null;

  UserInfoModel? get userInfo => _userRepository.currentUser;

  // The repository updates the cached user after a successful remote write,
  // so the `setX` callbacks only need to refresh the UI.
  void setName() => notifyListeners();

  void setUsername() => notifyListeners();

  void setPhoneNumber() => notifyListeners();

  void setGender(Gender? value) => notifyListeners();

  void setDateOfBirth(DateTime value) => notifyListeners();

  bool _handleUpdateResult(Result<void> result) {
    switch (result) {
      case Success():
        return true;
      case Failure(:final exception):
        _error = exception;
        return false;
    }
  }

  Future<bool> changeName() async {
    _error = null;
    final result = await _userRepository.updateName(
      firstNameController.text,
      lastNameController.text,
    );
    return _handleUpdateResult(result);
  }

  Future<bool> changeUsername() async {
    _error = null;
    final result = await _userRepository.updateUsername(
      usernameController.text,
    );
    return _handleUpdateResult(result);
  }

  Future<bool> changePhoneNumber() async {
    _error = null;
    final result = await _userRepository.updatePhoneNumber(
      phoneController.text,
    );
    return _handleUpdateResult(result);
  }

  Future<bool> changeGender(Gender gender) async {
    _error = null;
    final result = await _userRepository.updateGender(gender);
    return _handleUpdateResult(result);
  }

  Future<bool> changeDateOfBirth(DateTime value) async {
    _error = null;
    final result = await _userRepository.updateDateOfBirth(value);
    return _handleUpdateResult(result);
  }

  Future<AuthErrorType?> signOut() async {
    final result = await _authRepository.signOut();
    _userRepository.clearCurrentUser();
    if (result is Success<void>) {
      await _cartRepository.clearCart();
      _wishlistRepository.clear();
    }
    if (result case Failure(:final exception)) {
      return exception.getAuthErrorType();
    }
    return null;
  }
}
