import 'dart:async';

import 'package:flutter/foundation.dart';

import '/data/repositories/auth_repository.dart';
import '/data/repositories/cart_repository.dart';
import '/data/repositories/user_repository.dart';
import '/data/repositories/wishlist_repository.dart';

/// Ends the local session when Firebase signs the user out on its own
/// (account deleted or disabled, token revoked).
///
/// Intentional sign-outs clear the current user first, so they are ignored.
///
/// Known edge: if the session ends while a `Loading` dialog is open, that
/// dialog's `pop` runs after [onSessionEnded] has already navigated.
class SessionGuardProvider with ChangeNotifier {
  SessionGuardProvider({
    required AuthRepository authRepository,
    required UserRepository userRepository,
    required CartRepository cartRepository,
    required WishlistRepository wishlistRepository,
    required VoidCallback onSessionEnded,
  }) : _userRepository = userRepository,
       _cartRepository = cartRepository,
       _wishlistRepository = wishlistRepository,
       _onSessionEnded = onSessionEnded {
    _subscription = authRepository.userIdChanges.listen(_onUserIdChanged);
  }

  final UserRepository _userRepository;
  final CartRepository _cartRepository;
  final WishlistRepository _wishlistRepository;
  final VoidCallback _onSessionEnded;

  late final StreamSubscription<String?> _subscription;

  Future<void> _onUserIdChanged(String? uid) async {
    if (uid != null || _userRepository.currentUser == null) {
      return;
    }

    _userRepository.clearCurrentUser();
    await _cartRepository.clearCart();
    _wishlistRepository.clear();
    _onSessionEnded();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
