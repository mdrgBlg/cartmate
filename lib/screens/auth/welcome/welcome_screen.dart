import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/data/models/result.dart';
import '/data/repositories/auth_repository.dart';
import '/data/repositories/user_repository.dart';
import '/models/user_info_model.dart';
import '../../app/home/home_providers/home_provider.dart';
import '../../app/home/home_screen.dart';
import '../login/login_providers/login_provider.dart';
import '../login/login_screen.dart';
import '../splash_screen.dart';
import 'welcome_providers/welcome_provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const routeName = '/welcome';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => WelcomeProvider(
        authRepository: ctx.read<AuthRepository>(),
        userRepository: ctx.read<UserRepository>(),
      ),
      child: const _WelcomeView(),
    );
  }
}

class _WelcomeView extends StatelessWidget {
  const _WelcomeView();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WelcomeProvider>(context, listen: false);

    return FutureBuilder<Result<UserInfoModel>?>(
      future: provider.sessionFuture,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }
        if (snapshot.data is Success<UserInfoModel>) {
          return ChangeNotifierProvider(
            create: (_) => HomeProvider(),
            child: HomeScreen(),
          );
        }
        return ChangeNotifierProvider(
          create: (ctx) => LoginProvider(
            authRepository: ctx.read<AuthRepository>(),
            userRepository: ctx.read<UserRepository>(),
          ),
          child: const LoginScreen(),
        );
      },
    );
  }
}
