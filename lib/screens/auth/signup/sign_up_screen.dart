import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '/constants/custom_colors.dart';
import '/models/response_model.dart';
import '/utils/custom_navigator.dart';
import '/utils/helpers.dart';
import '/utils/loading.dart';
import '/utils/snack_bar_popup.dart';
import '/widgets/custom_button.dart';
import '/widgets/input_field.dart';
import '/widgets/password_field.dart';
import '../welcome/welcome_screen.dart';
import 'date_picker.dart';
import 'gender_selector.dart';
import 'sign_up_providers/sign_up_provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  static const routeName = '/signup';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 52,
          backgroundColor: CustomColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        resizeToAvoidBottomInset: true,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 2 - 52,
                      color: Colors.lightBlue,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 2 - 12,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Consumer<SignUpProvider>(
                builder: (_, signUpProvider, child) => Center(
                  child: Card(
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
                      child: SingleChildScrollView(
                        child: Column(
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
                                    controller:
                                        signUpProvider.firstNameController,
                                  ),
                                ),
                                Flexible(
                                  child: InputField(
                                    hintText: "Last name",
                                    onInputChanged: () {
                                      signUpProvider.validateField();
                                    },
                                    controller:
                                        signUpProvider.lastNameController,
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
                              padding: const EdgeInsets.only(
                                top: 12,
                                bottom: 8,
                              ),
                              child: InputField(
                                hintText: "Phone number",
                                onInputChanged: () {
                                  signUpProvider.validateField();
                                },
                                controller:
                                    signUpProvider.phoneNumberController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Consumer<SignUpProvider>(
                                      builder: (_, signUpProvider, child) =>
                                          GenderSelector(
                                            value:
                                                signUpProvider.selectedGender,
                                            onChanged: (newValue) =>
                                                signUpProvider.setGender(
                                                  newValue,
                                                ),
                                            genders: Helpers.genders,
                                          ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Column(
                                      children: [
                                        DatePicker(
                                          dateController:
                                              signUpProvider.dateController,
                                          pickedDate: signUpProvider.pickedDate,
                                          onDatePicked: (DateTime? pickedDate) {
                                            if (pickedDate != null) {
                                              signUpProvider.setPickedDate(
                                                pickedDate,
                                              );
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
                                passwordVisibility:
                                    signUpProvider.passwordVisibility,
                                changeVisibility:
                                    signUpProvider.changePasswordVisibility,
                              ),
                            ),
                            CustomButton(
                              buttonText: "Sign Up",
                              enable: signUpProvider.signUpButtonEnable,
                              onPress: () {
                                ResponseModel responseModel = ResponseModel(
                                  success: false,
                                );
                                Loading.callLoading(
                                  context: context,
                                  callback: () async {
                                    responseModel = await signUpProvider
                                        .signUp();
                                  },
                                  onFinished: () {
                                    if (responseModel.success) {
                                      SnackBarPopup.showMessage(
                                        context,
                                        message: "You successfully signed up!",
                                        snackBarMessageType:
                                            SnackBarMessageType.success,
                                      );
                                      CustomNavigator(context).pushReplacement(
                                        routeName: WelcomeScreen.routeName,
                                        screen: const WelcomeScreen(),
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
                          ],
                        ),
                      ),
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
