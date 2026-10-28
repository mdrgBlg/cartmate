import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/core/l10n/app_localizations.dart';
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
        wishlistRepository: ctx.read(),
      ),
      child: const _SignUpScreen(),
    );
  }
}

class _SignUpScreen extends StatelessWidget {
  const _SignUpScreen();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return AuthLayout(
      cardMargin: const EdgeInsets.only(bottom: 52, left: 32, right: 32),
      child: Consumer<SignUpProvider>(
        builder: (_, signUpProvider, child) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                spacing: 12,
                children: [
                  Flexible(
                    child: InputField(
                      padding: EdgeInsets.zero,
                      hintText: localization.firstName,
                      onInputChanged: () {
                        signUpProvider.validateField();
                      },
                      controller: signUpProvider.firstNameController,
                    ),
                  ),
                  Flexible(
                    child: InputField(
                      padding: EdgeInsets.zero,
                      hintText: localization.lastName,
                      onInputChanged: () {
                        signUpProvider.validateField();
                      },
                      controller: signUpProvider.lastNameController,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: InputField(
                hintText: localization.signUpUsername,
                onInputChanged: () {
                  signUpProvider.validateField();
                },
                controller: signUpProvider.usernameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: InputField(
                hintText: localization.signUpEmail,
                onInputChanged: () {
                  signUpProvider.validateField();
                },
                controller: signUpProvider.eMailController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 8),
              child: InputField(
                hintText: localization.signUpPhoneNumber,
                onInputChanged: () {
                  signUpProvider.validateField();
                },
                controller: signUpProvider.phoneNumberController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
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
                    // DropdownButton draws its underline 8px above its bottom.
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: DatePicker(
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
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: PasswordField(
                hintText: localization.signUpPassword,
                onInputChanged: () {
                  signUpProvider.validateField();
                },
                controller: signUpProvider.passwordController,
              ),
            ),
            CustomButton(
              buttonText: localization.signUpButton,
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
                        message: localization.signUpSuccess,
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
