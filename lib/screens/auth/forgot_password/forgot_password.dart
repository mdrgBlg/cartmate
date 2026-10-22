import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/data/models/auth_exception.dart';
import '/data/repositories/auth_repository.dart';
import '/utils/auth_error_message.dart';
import '/utils/custom_navigator.dart';
import '/utils/loading.dart';
import '/utils/snack_bar_popup.dart';
import '/widgets/custom_button.dart';
import '/widgets/input_field.dart';
import '/widgets/layouts/auth_layout.dart';
import '../login/login_providers/login_provider.dart';
import '../login/login_screen.dart';
import 'providers/forgot_password_provider.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ForgotPasswordProvider>(
      context,
      listen: false,
    );
    final textTheme = Theme.of(context).textTheme;
    return AuthLayout(
      cardMargin: const EdgeInsets.only(bottom: 52, left: 32, right: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              "Forgot password",
              style: textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Enter your email and we will send you a password reset link",
              style: textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 28),
            child: InputField(
              hintText: "E-mail",
              onInputChanged: () => provider.validateField(),
              controller: provider.emailController,
            ),
          ),
          Selector<ForgotPasswordProvider, bool>(
            selector: (_, provider) => provider.submitEnabled,
            builder: (context, submitEnabled, child) => CustomButton(
              buttonText: "Submit",
              enable: submitEnabled,
              onPress: () => onSubmitTap(context),
            ),
          ),
        ],
      ),
    );
  }

  void onSubmitTap(BuildContext context) {
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
            message: "Link to reset your password is sent to your email",
            snackBarMessageType: SnackBarMessageType.success,
          );
          CustomNavigator(context).pushReplacement(
            routeName: LoginScreen.routeName,
            screen: ChangeNotifierProvider(
              create: (ctx) => LoginProvider(
                authRepository: ctx.read<AuthRepository>(),
                userRepository: ctx.read(),
              ),
              child: const LoginScreen(),
            ),
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
