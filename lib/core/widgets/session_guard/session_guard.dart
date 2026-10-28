import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/screens/auth/login/login_screen.dart';
import 'providers/session_guard_provider.dart';

class SessionGuard extends StatelessWidget {
  const SessionGuard({
    required this.navigatorKey,
    required this.child,
    super.key,
  });

  final GlobalKey<NavigatorState> navigatorKey;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // The provider has no UI state; `lazy: false` makes it start listening
    // right away.
    return ChangeNotifierProvider(
      lazy: false,
      create: (context) => SessionGuardProvider(
        authRepository: context.read(),
        userRepository: context.read(),
        cartRepository: context.read(),
        wishlistRepository: context.read(),
        onSessionEnded: () => navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute<void>(
            settings: const RouteSettings(name: LoginScreen.routeName),
            builder: (_) => const LoginScreen(),
          ),
          (_) => false,
        ),
      ),
      child: child,
    );
  }
}
