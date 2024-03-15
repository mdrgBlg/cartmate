import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static final themeData = ThemeData(
    useMaterial3: false,
    dividerColor: Colors.transparent,
    typography: Typography.material2018(),
    textTheme: GoogleFonts.nunitoTextTheme(),
  );
}

class CustomIcons {
  static const splashIcon = 'assets/ecommerce.png';
  static const cartIcon = 'assets/cart_image.png';
  static const sports = 'assets/sports.png';
}
