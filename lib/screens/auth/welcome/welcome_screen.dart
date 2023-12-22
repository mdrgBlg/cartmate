import 'package:e_commerce/screens/auth/login/login_screen.dart';
import 'package:e_commerce/screens/auth/splash_screen.dart';
import 'package:e_commerce/screens/auth/welcome/welcome_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const routeName = '/welcome';

  @override
  Widget build(BuildContext context) {
    final welcomeProvider =
        Provider.of<WelcomeProvider>(context, listen: false);
    return FutureBuilder(
      future: welcomeProvider.checkAccessToken(),
      builder: (context, snapshot) =>
          snapshot.data == true ? const LoginScreen() : const SplashScreen(),
    );
  }
}
