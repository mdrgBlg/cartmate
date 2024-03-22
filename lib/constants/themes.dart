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
