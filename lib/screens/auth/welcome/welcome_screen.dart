import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/home/home_screen.dart';
import '../login/login_providers/login_provider.dart';
import '../login/login_screen.dart';
import '/constants/constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const routeName = '/welcome';

  @override
  Widget build(BuildContext context) {
    return Constants.firebaseAuth.currentUser != null
        ? const HomeScreen()
        : ChangeNotifierProvider(
            create: (_) => LoginProvider(),
            child: const LoginScreen(),
          );
  }
}
