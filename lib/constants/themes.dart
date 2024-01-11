import 'package:flutter/material.dart';

import 'custom_colors.dart';

class Themes {
  static const font = 'Nunito';
  static final lightTheme = ThemeData(
    fontFamily: font,
    useMaterial3: false,
    dividerColor: Colors.transparent,
    typography: Typography.material2018(),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: CustomColors.text,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      displayMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
      ),
      displaySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: CustomColors.text,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: CustomColors.text,
      ),
      headlineSmall: TextStyle(
        color: CustomColors.text,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: CustomColors.primary,
      ),
      titleSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        color: CustomColors.primary,
        backgroundColor: Colors.transparent,
        fontSize: 18,
      ),
      bodySmall: TextStyle(),
      labelSmall: TextStyle(),
    ),
  );
}

class CustomIcons {
  static const splashIcon = 'assets/ecommerce.png';
  static const cartIcon = 'assets/cart.png';
}
