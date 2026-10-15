import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/constants/custom_colors.dart';
import '/constants/custom_icons.dart';
import '/data/models/auth_exception.dart';
import '/data/repositories/auth_repository.dart';
import '/providers/main_provider.dart';
import '/utils/auth_error_message.dart';
import '/utils/custom_navigator.dart';
import '/utils/loading.dart';
import '/utils/snack_bar_popup.dart';
import '/widgets/auth_layout.dart';
import '/widgets/custom_button.dart';
import '/widgets/input_field.dart';
import '/widgets/password_field.dart';
import '../../app/home/home_providers/home_provider.dart';
import '../../app/home/home_screen.dart';
import '../forgot_password/forgot_password.dart';
import '../forgot_password/providers/forgot_password_provider.dart';
import '../signup/sign_up_providers/sign_up_provider.dart';
import '../signup/sign_up_screen.dart';
import 'login_providers/login_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    return AuthLayout(
      showAppBar: false,
      backgroundColor: Colors.lightBlue,
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
                  screen: ChangeNotifierProvider(
                    create: (ctx) => SignUpProvider(
                      authRepository: ctx.read<AuthRepository>(),
                    ),
                    child: const SignUpScreen(),
                  ),
                );
              },
              child: Text(
                'Sign Up',
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
              const Text(
                "Log In To CartMate",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w300,
                  color: CustomColors.appName,
                ),
                textScaler: TextScaler.linear(1),
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
            hintText: "E - mail:",
            onInputChanged: () => loginProvider.validateField(),
            controller: loginProvider.emailController,
          ),
          const SizedBox(height: 12),
          PasswordField(
            hintText: "Password:",
            onInputChanged: () => loginProvider.validateField(),
            controller: loginProvider.passwordController,
          ),
          const SizedBox(height: 20),
          Selector<LoginProvider, bool>(
            selector: (_, provider) => provider.loginButtonEnable,
            builder: (context, loginButtonEnable, child) => CustomButton(
              buttonText: "Log in",
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
                  screen: ChangeNotifierProvider(
                    create: (ctx) => ForgotPasswordProvider(
                      authRepository: ctx.read<AuthRepository>(),
                    ),
                    child: const ForgotPassword(),
                  ),
                );
              },
              child: Text(
                'Forgot password?',
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
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    bool isSuccess = false;

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
          context.read<MainProvider>().setUserInfo(loginProvider.loggedInUser);
          SnackBarPopup.showMessage(
            context,
            message: "You successfully logged in!",
            snackBarMessageType: SnackBarMessageType.success,
          );
          CustomNavigator(context).pushReplacement(
            routeName: HomeScreen.routeName,
            screen: ChangeNotifierProvider(
              create: (_) => HomeProvider(),
              child: HomeScreen(),
            ),
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
