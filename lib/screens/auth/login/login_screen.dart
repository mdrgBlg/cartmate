import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/constants/themes.dart';
import '/widgets/custom_button.dart';
import '/widgets/input_field.dart';
import 'login_providers/login_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: screenHeight / 2,
                  color: Colors.lightBlue,
                ),
                Container(
                  height: screenHeight / 2,
                  color: Colors.white,
                ),
              ],
            ),
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () => {
                    Navigator.of(context).pushNamed("/signup"),
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                      decorationThickness: 1.0,
                      color: CustomColors.appName,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: screenHeight / 12,
              child: Column(
                children: [
                  Image.asset(
                    CustomIcons.cartIcon,
                    width: 100,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Log In To eShop",
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
            Column(
              children: [
                SizedBox(
                  height: screenHeight / 2 - 150,
                ),
                Consumer<LoginProvider>(
                  builder: (context, loginProvider, child) => Center(
                    child: Card(
                      elevation: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        height: 300,
                        width: 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InputField(
                              hintText: "E - mail:",
                              isValid: loginProvider.eMailEmpty,
                              onInputChanged: () {
                                loginProvider.validateField();
                              },
                              controller: loginProvider.eMailController,
                            ),
                            InputField(
                              hintText: "Password:",
                              isValid: loginProvider.passwordEmpty,
                              onInputChanged: () {
                                loginProvider.validateField();
                              },
                              controller: loginProvider.passwordController,
                            ),
                            const SizedBox(height: 20),
                            CustomButton(
                              buttonText: "Log In",
                              enable: loginProvider.loginButtonEnable,
                              onPress: () {
                                loginProvider.login();
                              },
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              child: InkWell(
                                onTap: () => {},
                                child: const Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
