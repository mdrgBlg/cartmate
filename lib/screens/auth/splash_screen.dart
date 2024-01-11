import 'package:e_commerce/constants/themes.dart';
import 'package:flutter/material.dart';

import '../../constants/custom_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const routeName = '/splash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              CustomColors.primary,
              CustomColors.secondary,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                CustomIcons.cartIcon,
                width: 120,
              ),
              const SizedBox(height: 10),
              const Text(
                "eShop",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: CustomColors.appName,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
