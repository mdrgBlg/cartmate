import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/constants/constants.dart';
import '/constants/custom_colors.dart';
import '/utils/custom_navigator.dart';
import '/utils/loading.dart';
import 'login/login_providers/login_provider.dart';
import 'login/login_screen.dart';

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: OutlinedButton(
        onPressed: () async {
          Loading.callLoading(
            context: context,
            callback: () async {
              await Constants.firebaseAuth.signOut();
            },
            onFinished: () => CustomNavigator(context).pushReplacement(
              routeName: LoginScreen.routeName,
              screen: ChangeNotifierProvider(
                create: (context) => LoginProvider(),
                child: const LoginScreen(),
              ),
            ),
          );
        },
        child: Text(
          "Log out",
          style: textTheme.bodyLarge!.copyWith(color: CustomColors.primary),
        ),
      ),
    );
  }
}
