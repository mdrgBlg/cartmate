import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/constants/custom_colors.dart';
import '/constants/custom_icons.dart';
import '/models/response_model.dart';
import '/utils/custom_navigator.dart';
import '/utils/loading.dart';
import '/utils/snack_bar_popup.dart';
import '/widgets/custom_button.dart';
import '/widgets/input_field.dart';
import '/widgets/password_field.dart';
import '../../app/home/home_providers/home_provider.dart';
import '../../app/home/home_screen.dart';
import '../forgot_password.dart';
import '../signup/sign_up_providers/sign_up_provider.dart';
import '../signup/sign_up_screen.dart';
import 'login_providers/login_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: SingleChildScrollView(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Column(
                  children: [
                    Container(
                      height: screenHeight / 2 - 22,
                      color: Colors.lightBlue,
                    ),
                    Container(
                      height: screenHeight / 2 - 22,
                      color: Colors.white,
                    ),
                  ],
                ),
                Positioned(
                  top: 8,
                  right: 16,
                  child: Container(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () => CustomNavigator(context).pushNavigation(
                        routeName: SignUpScreen.routeName,
                        screen: ChangeNotifierProvider(
                          create: (_) => SignUpProvider(),
                          child: const SignUpScreen(),
                        ),
                      ),
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
                Consumer<LoginProvider>(
                  builder: (context, loginProvider, child) => Card(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 3,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 24,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InputField(
                            hintText: "E - mail:",
                            onInputChanged: () {
                              loginProvider.validateField();
                            },
                            controller: loginProvider.emailController,
                          ),
                          const SizedBox(height: 12),
                          PasswordField(
                            hintText: "Password:",
                            onInputChanged: () {
                              loginProvider.validateField();
                            },
                            controller: loginProvider.passwordController,
                            passwordVisibility:
                                loginProvider.passwordVisibility,
                            changeVisibility: loginProvider.changeVisibility,
                          ),
                          const SizedBox(height: 20),
                          CustomButton(
                            buttonText: "Log in",
                            enable: loginProvider.loginButtonEnable,
                            onPress: () {
                              ResponseModel responseModel = ResponseModel(
                                success: false,
                              );
                              Loading.callLoading(
                                context: context,
                                callback: () async {
                                  responseModel = await loginProvider.login(
                                    context,
                                  );
                                },
                                onFinished: () {
                                  if (responseModel.success) {
                                    SnackBarPopup.showMessage(
                                      context,
                                      message: "You successfully logged in!",
                                      snackBarMessageType:
                                          SnackBarMessageType.success,
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
                                      message:
                                          responseModel.error ??
                                          "Something went wrong.",
                                      snackBarMessageType:
                                          SnackBarMessageType.error,
                                    );
                                  }
                                },
                              );
                            },
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 15),
                            child: InkWell(
                              onTap: () =>
                                  CustomNavigator(context).pushNavigation(
                                    routeName: ForgotPassword.routeName,
                                    screen: ChangeNotifierProvider.value(
                                      value: loginProvider,
                                      child: const ForgotPassword(),
                                    ),
                                  ),
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
