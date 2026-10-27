import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '/core/widgets/custom_button.dart';
import '/core/widgets/date_picker.dart';
import '/core/widgets/gender_selector.dart';
import '/core/widgets/input_field.dart';
import '/core/widgets/layouts/auth_layout.dart';
import '/core/widgets/password_field.dart';
import '/data/models/auth_exception.dart';
import '/utils/auth_error_message.dart';
import '/utils/custom_navigator.dart';
import '/utils/global_enums.dart';
import '/utils/loading.dart';
import '/utils/snack_bar_popup.dart';
import '../welcome/welcome_screen.dart';
import 'sign_up_providers/sign_up_provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  static const routeName = '/signup';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => SignUpProvider(
        authRepository: ctx.read(),
        cartRepository: ctx.read(),
      ),
      child: const _SignUpScreen(),
    );
  }
}

class _SignUpScreen extends StatelessWidget {
  const _SignUpScreen();

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      cardMargin: const EdgeInsets.only(bottom: 52, left: 32, right: 32),
      child: Consumer<SignUpProvider>(
        builder: (_, signUpProvider, child) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Flexible(
                  child: InputField(
                    hintText: "First name",
                    onInputChanged: () {
                      signUpProvider.validateField();
                    },
                    controller: signUpProvider.firstNameController,
                  ),
                ),
                Flexible(
                  child: InputField(
                    hintText: "Last name",
                    onInputChanged: () {
                      signUpProvider.validateField();
                    },
                    controller: signUpProvider.lastNameController,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: InputField(
                hintText: "Username",
                onInputChanged: () {
                  signUpProvider.validateField();
                },
                controller: signUpProvider.usernameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: InputField(
                hintText: "E-mail",
                onInputChanged: () {
                  signUpProvider.validateField();
                },
                controller: signUpProvider.eMailController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 8),
              child: InputField(
                hintText: "Phone number",
                onInputChanged: () {
                  signUpProvider.validateField();
                },
                controller: signUpProvider.phoneNumberController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Consumer<SignUpProvider>(
                      builder: (_, signUpProvider, child) => GenderSelector(
                        genders: Gender.values,
                        initialGender: signUpProvider.selectedGender,
                        onChanged: signUpProvider.setGender,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        DatePicker(
                          dateController: signUpProvider.dateController,
                          pickedDate: signUpProvider.pickedDate,
                          onDatePicked: (DateTime? pickedDate) {
                            if (pickedDate != null) {
                              signUpProvider.setPickedDate(pickedDate);
                              signUpProvider.validateField();
                            } else {
                              signUpProvider.validateField();
                            }
                          },
                        ),
                        const Gap(16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: PasswordField(
                hintText: "Password:",
                onInputChanged: () {
                  signUpProvider.validateField();
                },
                controller: signUpProvider.passwordController,
              ),
            ),
            CustomButton(
              buttonText: "Sign Up",
              enable: signUpProvider.signUpButtonEnable,
              onPress: () {
                bool isSuccess = false;
                Loading.callLoading(
                  context: context,
                  callback: () async {
                    isSuccess = await signUpProvider.signUp();
                  },
                  onFinished: () {
                    if (!context.mounted) {
                      return;
                    }
                    if (isSuccess) {
                      SnackBarPopup.showMessage(
                        context,
                        message: "You successfully signed up!",
                        snackBarMessageType: SnackBarMessageType.success,
                      );
                      CustomNavigator(context).pushReplacement(
                        routeName: WelcomeScreen.routeName,
                        screen: const WelcomeScreen(),
                      );
                    } else {
                      SnackBarPopup.showMessage(
                        context,
                        message: (signUpProvider.error ?? AuthErrorType.unknown)
                            .message(context),
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
    );
  }
}
