import 'package:e_commerce/screens/auth/login/login_providers/login_provider.dart';
import 'package:e_commerce/screens/auth/login/login_screen.dart';
import 'package:e_commerce/screens/screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../helpers/custom_navigator.dart';
import '../../../helpers/loading.dart';

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Center(
        child: OutlinedButton(
          onPressed: () async {
            Loading.callLoading(
              context: context,
              callback: () async {
                await Constants.firebaseAuth.signOut();
              },
              onFinished: () => CustomNavigator.pushReplacement(
                context: context,
                routeName: LoginScreen.routeName,
                screen: ChangeNotifierProvider(
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
