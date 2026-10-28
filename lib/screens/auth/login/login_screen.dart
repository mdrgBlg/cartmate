import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/core/l10n/app_localizations.dart';
import '/core/styles/custom_colors.dart';
import '/core/widgets/custom_button.dart';
import '/core/widgets/input_field.dart';
import '/core/widgets/layouts/auth_layout.dart';
import '/core/widgets/password_field.dart';
import '/data/models/auth_exception.dart';
import '/utils/assets/custom_icons.dart';
import '/utils/auth_error_message.dart';
import '/utils/custom_navigator.dart';
import '/utils/loading.dart';
import '/utils/snack_bar_popup.dart';
import '../../app/home/home_screen.dart';
import '../forgot_password/forgot_password.dart';
import '../signup/sign_up_screen.dart';
import 'login_providers/login_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => LoginProvider(
        authRepository: ctx.read(),
        cartRepository: ctx.read(),
        userRepository: ctx.read(),
        wishlistRepository: ctx.read(),
      ),
      child: const _LoginScreen(),
    );
  }
}

class _LoginScreen extends StatelessWidget {
  const _LoginScreen();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    return AuthLayout(
      showAppBar: false,
      backgroundColor: CustomColors.primary,
      overlays: [
        Positioned(
          top: 8,
          right: 16,
          child: Container(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                CustomNavigator(context).pushNavigation(
                  routeName: SignUpScreen.routeName,
                  screen: const SignUpScreen(),
                );
              },
              child: Text(
                localization.loginSignUp,
                style: textTheme.labelLarge!.copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: CustomColors.appName,
                  decorationThickness: 1.5,
                  color: CustomColors.appName,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 52,
          child: Column(
            children: [
              Image.asset(CustomIcons.cartIcon, width: 80),
              const SizedBox(height: 12),
              Text(
                localization.loginTitle,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w300,
                  color: CustomColors.appName,
                ),
                textScaler: const TextScaler.linear(1),
              ),
            ],
          ),
        ),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InputField(
            hintText: localization.loginEmailHint,
            onInputChanged: () => loginProvider.validateField(),
            controller: loginProvider.emailController,
          ),
          const SizedBox(height: 12),
          PasswordField(
            hintText: localization.loginPasswordHint,
            onInputChanged: () => loginProvider.validateField(),
            controller: loginProvider.passwordController,
          ),
          const SizedBox(height: 20),
          Selector<LoginProvider, bool>(
            selector: (_, provider) => provider.loginButtonEnable,
            builder: (context, loginButtonEnable, child) => CustomButton(
              buttonText: localization.loginButton,
              enable: loginButtonEnable,
              onPress: () => onLoginTap(context),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            child: InkWell(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                CustomNavigator(context).pushNavigation(
                  routeName: ForgotPassword.routeName,
                  screen: const ForgotPassword(),
                );
              },
              child: Text(
                localization.loginForgotPassword,
                style: textTheme.bodyMedium!.copyWith(
                  decoration: TextDecoration.underline,
                  decorationThickness: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onLoginTap(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    bool isSuccess = false;

    FocusManager.instance.primaryFocus?.unfocus();
    Loading.callLoading(
      context: context,
      callback: () async {
        isSuccess = await loginProvider.login();
      },
      onFinished: () {
        if (!context.mounted) {
          return;
        }
        if (isSuccess) {
          SnackBarPopup.showMessage(
            context,
            message: localization.loginSuccess,
            snackBarMessageType: SnackBarMessageType.success,
          );
          CustomNavigator(context).pushReplacement(
            routeName: HomeScreen.routeName,
            screen: const HomeScreen(),
          );
        } else {
          SnackBarPopup.showMessage(
            context,
            message: (loginProvider.error ?? AuthErrorType.unknown).message(
              context,
            ),
            snackBarMessageType: SnackBarMessageType.error,
          );
        }
      },
    );
  }
}
