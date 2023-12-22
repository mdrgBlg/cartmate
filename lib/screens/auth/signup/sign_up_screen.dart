import 'package:e_commerce/constants/themes.dart';
import 'package:e_commerce/screens/auth/signup/signup_providers/signup_provider.dart';
import 'package:e_commerce/widgets/custom_button.dart';
import 'package:e_commerce/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  static const routeName = '/signup';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpProvider(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Stack(
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
              Positioned.fill(
                top: MediaQuery.of(context).size.height / 15,
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
              Positioned.fill(
                child: Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 4,
                    color: Colors.white,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.3,
                      height: MediaQuery.of(context).size.height / 2.1,
                      child: Consumer<SignUpProvider>(
                        builder: (context, signUpProvider, child) =>
                            SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 10),
                              InputField(
                                hintText: "E-mail",
                                isValid: signUpProvider.eMailEmpty,
                                onInputChanged: () {
                                  signUpProvider.validateField();
                                },
                                controller: signUpProvider.eMailController,
                              ),
                              const SizedBox(height: 10),
                              const SizedBox(height: 10),
                              InputField(
                                hintText: "Password:",
                                isValid: signUpProvider.passwordEmpty,
                                onInputChanged: () {
                                  signUpProvider.validateField();
                                },
                                controller: signUpProvider.passwordController,
                              ),
                              const SizedBox(height: 10),
                              InputField(
                                hintText: "Confirm password:",
                                isValid: signUpProvider.confirmPasswordEmpty,
                                onInputChanged: () {
                                  signUpProvider.validateField();
                                },
                                controller:
                                    signUpProvider.confirmPasswordController,
                              ),
                              const SizedBox(height: 20),
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
