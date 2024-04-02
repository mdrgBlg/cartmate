import 'package:e_commerce/screens/app/home/home_providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/home/home_screen.dart';
import '../login/login_providers/login_provider.dart';
import '../login/login_screen.dart';
import '../splash_screen.dart';
import '/constants/constants.dart';
import '/models/response_model.dart';
import '/providers/main_provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const routeName = '/welcome';

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(
      context,
      listen: false,
    );
    return Constants.firebaseAuth.currentUser != null
        ? FutureBuilder<ResponseModel>(
            future: mainProvider.fetchUserInfo(Constants.firebaseAuth.currentUser!.uid),
            builder: (_, snapshot) => snapshot.connectionState == ConnectionState.waiting
                ? const SplashScreen()
                : ChangeNotifierProvider(
                    create: (_) => HomeProvider(),
                    child: HomeScreen(),
                  ),
          )
        : ChangeNotifierProvider(
            create: (_) => LoginProvider(),
            child: const LoginScreen(),
          );
  }
}
