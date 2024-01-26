import 'package:e_commerce/constants/custom_colors.dart';
import 'package:e_commerce/screens/auth/signup/sign_up_providers/signup_provider.dart';
import 'package:e_commerce/widgets/custom_button.dart';
import 'package:e_commerce/widgets/input_field.dart';
import 'package:e_commerce/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          child: SingleChildScrollView(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 2 - 72,
                      color: Colors.lightBlue,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 2 - 22,
                      color: Colors.white,
                    ),
                  ],
                ),
                Consumer<SignUpProvider>(
                  builder: (context, signUpProvider, child) => Card(
                    margin: const EdgeInsets.only(bottom: 52),
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
                              padding: const EdgeInsets.only(top: 12),
                              child: InputField(
                                hintText: "Phone number",
                                onInputChanged: () {
                                  signUpProvider.validateField();
                                },
                                controller: signUpProvider.phoneNumberController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12, bottom: 20),
                              child: PasswordField(
                                hintText: "Password:",
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
