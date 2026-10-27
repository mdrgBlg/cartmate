import 'package:flutter/material.dart';

import '/data/models/auth_exception.dart';
import '/data/models/result.dart';
import '/data/repositories/auth_repository.dart';
import '/data/repositories/cart_repository.dart';
import '/data/repositories/user_repository.dart';
import '/data/repositories/wishlist_repository.dart';
import '/models/user_info_model.dart';
import '/utils/extensions/exception_extension.dart';

class LoginProvider with ChangeNotifier {
  LoginProvider({
    required AuthRepository authRepository,
    required CartRepository cartRepository,
    required UserRepository userRepository,
    required WishlistRepository wishlistRepository,
  }) : _authRepository = authRepository,
       _cartRepository = cartRepository,
       _userRepository = userRepository,
       _wishlistRepository = wishlistRepository;

  final AuthRepository _authRepository;
  final CartRepository _cartRepository;
  final UserRepository _userRepository;
  final WishlistRepository _wishlistRepository;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _loginButtonEnable = false;
  bool get loginButtonEnable => _loginButtonEnable;

  AuthErrorType? _error;
  AuthErrorType? get error => _error;

  UserInfoModel? _loggedInUser;
  UserInfoModel? get loggedInUser => _loggedInUser;

  void validateField() {
    _loginButtonEnable =
        emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
    notifyListeners();
  }

  Future<bool> login() async {
    _error = null;

    final result = await _authRepository.login(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    switch (result) {
      case Success(:final data):
        _loggedInUser = data;
        _userRepository.setCurrentUser(_loggedInUser);
        // Drop any cart left by a previous user who never logged out properly.
        await _cartRepository.clearCart();
        _wishlistRepository.clear();

        return true;
      case Failure(:final exception):
        _error = exception.getAuthErrorType();
        return false;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
