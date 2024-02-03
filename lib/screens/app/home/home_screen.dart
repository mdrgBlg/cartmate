import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/login/login_providers/login_provider.dart';
import '../../auth/login/login_screen.dart';
import '/constants/constants.dart';
import '/helpers/custom_navigator.dart';
import '/helpers/loading.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: OutlinedButton(
          onPressed: () async {
            Loading.callLoading(
              context: context,
              callback: () async {
                await Constants.firebaseAuth.signOut();
              },
              onFinished: () => CustomNavigator.pushReplacement(
                context,
                ChangeNotifierProvider(
                  create: (context) => LoginProvider(),
                  child: const LoginScreen(),
                ),
              ),
            );
          },
          child: Text("Log out"),
        ),
      ),
    );
  }
}
