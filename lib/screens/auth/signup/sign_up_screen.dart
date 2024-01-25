import 'package:e_commerce/constants/themes.dart';
import 'package:e_commerce/screens/auth/signup/signup_providers/signup_provider.dart';
import 'package:e_commerce/widgets/custom_button.dart';
import 'package:e_commerce/widgets/input_field.dart';
import 'package:e_commerce/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode eMailNameFocusNode = FocusNode();
  final FocusNode phoneNumberFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  SignUpScreen({super.key});

  static const routeName = '/signup';

  @override
  Widget build(BuildContext context) {
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
                      height: MediaQuery.of(context).size.height / 2,
                      color: Colors.lightBlue,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 2,
                      color: Colors.white,
                    ),
                  ],
                ),
                Positioned(
                  top: 56,
                  child: Center(
                    child: Column(
                      children: [
                        Image.asset(
                          CustomIcons.cartIcon,
                          width: 80,
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                Consumer<SignUpProvider>(
                  builder: (context, signUpProvider, child) => Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 3,
                    color: Colors.white,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 20,
                      ),
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: MediaQuery.of(context).size.height / 1.75,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: InputField(
                                    hintText: "First name",
                                    isValid: signUpProvider.eMailEmpty,
                                    onInputChanged: () {
                                      signUpProvider.validateField();
                                    },
                                    controller: signUpProvider.firstNameController,
                                    focusNode: firstNameFocusNode,
                                  ),
                                ),
                                Flexible(
                                  child: InputField(
                                    hintText: "Last name",
                                    isValid: signUpProvider.eMailEmpty,
                                    onInputChanged: () {
                                      signUpProvider.validateField();
                                    },
                                    controller: signUpProvider.lastNameController,
                                    focusNode: lastNameFocusNode,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: InputField(
                                hintText: "Username",
                                isValid: signUpProvider.eMailEmpty,
                                onInputChanged: () {
                                  signUpProvider.validateField();
                                },
                                controller: signUpProvider.usernameController,
                                focusNode: usernameFocusNode,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: InputField(
                                hintText: "E-mail",
                                isValid: signUpProvider.eMailEmpty,
                                onInputChanged: () {
                                  signUpProvider.validateField();
                                },
                                controller: signUpProvider.eMailController,
                                focusNode: eMailNameFocusNode,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: InputField(
                                hintText: "Phone number",
                                isValid: signUpProvider.eMailEmpty,
                                onInputChanged: () {
                                  signUpProvider.validateField();
                                },
                                controller: signUpProvider.phoneNumberController,
                                focusNode: phoneNumberFocusNode,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12, bottom: 20),
                              child: PasswordField(
                                hintText: "Password:",
                                isValid: signUpProvider.passwordEmpty,
                                onInputChanged: () {
                                  signUpProvider.validateField();
                                },
                                controller: signUpProvider.passwordController,
                                passwordVisibility: signUpProvider.passwordVisibility,
                                changeVisibility: signUpProvider.changePasswordVisibility,
                              ),
                            ),
                            CustomButton(
                              buttonText: "Sign Up",
                              enable: signUpProvider.signUpButtonEnable,
                              onPress: () async {
                                signUpProvider.signUp();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
