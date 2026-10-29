import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/core/l10n/app_localizations.dart';
import '/core/styles/app_spacing.dart';
import '/core/widgets/custom_button.dart';
import '/core/widgets/input_field.dart';
import '/core/widgets/layouts/auth_layout.dart';
import '/data/models/auth_exception.dart';
import '/utils/auth_error_message.dart';
import '/utils/custom_navigator.dart';
import '/utils/loading.dart';
import '/utils/snack_bar_popup.dart';
import '../login/login_screen.dart';
import 'providers/forgot_password_provider.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  static const routeName = '/forgot-password';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => ForgotPasswordProvider(authRepository: ctx.read()),
      child: const _ForgotPassword(),
    );
  }
}

class _ForgotPassword extends StatelessWidget {
  const _ForgotPassword();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final provider = Provider.of<ForgotPasswordProvider>(
      context,
      listen: false,
    );
    final textTheme = Theme.of(context).textTheme;
    return AuthLayout(
      cardMargin: const EdgeInsets.only(
        bottom: 52,
        left: AppSpacing.xxxl,
        right: AppSpacing.xxxl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: Text(
              localization.forgotPasswordTitle,
              style: textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: AppSpacing.screenPadding,
            child: Text(
              localization.forgotPasswordDescription,
              style: textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 28),
            child: InputField(
              hintText: localization.forgotPasswordEmailHint,
              onInputChanged: () => provider.validateField(),
              controller: provider.emailController,
            ),
          ),
          Selector<ForgotPasswordProvider, bool>(
            selector: (_, provider) => provider.submitEnabled,
            builder: (context, submitEnabled, child) => CustomButton(
              buttonText: localization.forgotPasswordSubmit,
              enable: submitEnabled,
              onPress: () => onSubmitTap(context),
            ),
          ),
        ],
      ),
    );
  }

  void onSubmitTap(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final provider = Provider.of<ForgotPasswordProvider>(
      context,
      listen: false,
    );

    bool isSuccess = false;
    Loading.callLoading(
      context: context,
      callback: () async {
        isSuccess = await provider.submit();
      },
      onFinished: () {
        if (!context.mounted) {
          return;
        }
        if (isSuccess) {
          SnackBarPopup.showMessage(
            context,
            message: localization.forgotPasswordLinkSent,
            snackBarMessageType: SnackBarMessageType.success,
          );
          CustomNavigator(context).pushReplacement(
            routeName: LoginScreen.routeName,
            screen: const LoginScreen(),
          );
        } else {
          SnackBarPopup.showMessage(
            context,
            message: (provider.error ?? AuthErrorType.unknown).message(context),
            snackBarMessageType: SnackBarMessageType.error,
          );
        }
      },
    );
  }
}
