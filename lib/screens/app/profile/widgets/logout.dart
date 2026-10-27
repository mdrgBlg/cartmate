import 'package:flutter/material.dart';

import '/core/styles/custom_colors.dart';
import '/data/models/auth_exception.dart';
import '/utils/auth_error_message.dart';
import '/utils/custom_navigator.dart';
import '/utils/loading.dart';
import '/utils/snack_bar_popup.dart';
import '../../../auth/login/login_screen.dart';

class Logout extends StatelessWidget {
  const Logout({required this.signOut, super.key});
  final Future<AuthErrorType?> Function() signOut;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: OutlinedButton(
        onPressed: () async {
          AuthErrorType? authErrorType;
          Loading.callLoading(
            context: context,
            callback: () async {
              authErrorType = await signOut();
            },
            onFinished: () {
              if (!context.mounted) {
                return;
              }

              if (authErrorType == null) {
                CustomNavigator(context).pushReplacement(
                  routeName: LoginScreen.routeName,
                  screen: const LoginScreen(),
                );
              } else {
                SnackBarPopup.showMessage(
                  context,
                  message: authErrorType!.message(context),
                  snackBarMessageType: SnackBarMessageType.error,
                );
              }
            },
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
