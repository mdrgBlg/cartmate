import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/constants/custom_colors.dart';
import '/data/models/auth_exception.dart';
import '/data/repositories/auth_repository.dart';
import '/utils/auth_error_message.dart';
import '/utils/custom_navigator.dart';
import '/utils/loading.dart';
import '/utils/snack_bar_popup.dart';
import '/widgets/custom_button.dart';
import '/widgets/input_field.dart';
import 'providers/forgot_password_provider.dart';
import '../login/login_providers/login_provider.dart';
import '../login/login_screen.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 52,
          backgroundColor: CustomColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2 - 74,
                    color: Colors.lightBlue,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2 - 22,
                    color: Colors.white,
                  ),
                ],
              ),
              Consumer<ForgotPasswordProvider>(
                builder: (context, forgotPasswordProvider, child) => Card(
                  margin: const EdgeInsets.only(
                    bottom: 52,
                    left: 32,
                    right: 32,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 3,
                  color: Colors.white,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 24,
                    ),
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
                            onInputChanged: () {
                              forgotPasswordProvider.validateField();
                            },
                            controller: forgotPasswordProvider.emailController,
                          ),
                        ),
                        CustomButton(
                          buttonText: "Submit",
                          enable: forgotPasswordProvider.submitEnabled,
                          onPress: () {
                            bool isSuccess = false;
                            Loading.callLoading(
                              context: context,
                              callback: () async {
                                isSuccess = await forgotPasswordProvider
                                    .submit();
                              },
                              onFinished: () {
                                if (!context.mounted) {
                                  return;
                                }
                                if (isSuccess) {
                                  SnackBarPopup.showMessage(
                                    context,
                                    message:
                                        "Link to reset your password is sent to your email",
                                    snackBarMessageType:
                                        SnackBarMessageType.success,
                                  );
                                  CustomNavigator(context).pushReplacement(
                                    routeName: LoginScreen.routeName,
                                    screen: ChangeNotifierProvider(
                                      create: (ctx) => LoginProvider(
                                        authRepository: ctx
                                            .read<AuthRepository>(),
                                      ),
                                      child: const LoginScreen(),
                                    ),
                                  );
                                } else {
                                  SnackBarPopup.showMessage(
                                    context,
                                    message:
                                        (forgotPasswordProvider.error ??
                                                AuthErrorType.unknown)
                                            .message(context),
                                    snackBarMessageType:
                                        SnackBarMessageType.error,
                                  );
                                }
                              },
                            );
                          },
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
    );
  }
}
