import 'package:flutter/material.dart';

import '/core/l10n/app_localizations.dart';
import '/core/widgets/custom_button.dart';
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
    final localization = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 100,
      child: CustomButton(
        enable: true,
        margin: EdgeInsets.zero,
        buttonHeight: 40,
        color: colorScheme.surfaceContainerLowest,
        buttonText: localization.profileLogout,
        style: textTheme.bodyLarge!.copyWith(color: colorScheme.primary),
        onPress: () {
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
      ),
    );
  }
}
