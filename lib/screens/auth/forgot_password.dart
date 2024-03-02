import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/constants/custom_colors.dart';
import '/helpers/custom_navigator.dart';
import '/helpers/loading.dart';
import '/helpers/snack_bar_popup.dart';
import '/models/response_model.dart';
import '/widgets/custom_button.dart';
import '/widgets/input_field.dart';
import 'login/login_providers/login_provider.dart';
import 'login/login_screen.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

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
              Consumer<LoginProvider>(
                builder: (context, loginProvider, child) => Card(
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
                            style: textTheme.headlineMedium!.copyWith(
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
                              loginProvider.validateForgotPasswordField();
                            },
                            controller: loginProvider.forgotPasswordController,
                          ),
                        ),
                        CustomButton(
                          buttonText: "Submit",
                          enable: loginProvider.forgotPasswordEnable,
                          onPress: () {
                            ResponseModel responseModel = ResponseModel(success: false);
                            Loading.callLoading(
                              context: context,
                              callback: () async {
                                responseModel = await loginProvider.forgetPassword();
                              },
                              onFinished: () {
                                if (responseModel.success) {
                                  SnackBarPopup.showMessage(
                                    context,
                                    message: "Link to reset your password is sent to your email",
                                    snackBarMessageType: SnackBarMessageType.success,
                                  );
                                  CustomNavigator.pushReplacement(
                                    context: context,
                                    routeName: LoginScreen.routeName,
                                    screen: ChangeNotifierProvider(
                                      create: (context) => LoginProvider(),
                                      child: const LoginScreen(),
                                    ),
                                  );
                                } else {
                                  SnackBarPopup.showMessage(
                                    context,
                                    message: responseModel.error ?? "Something went wrong.",
                                    snackBarMessageType: SnackBarMessageType.error,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
