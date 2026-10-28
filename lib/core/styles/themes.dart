import 'package:flutter/material.dart';

import 'custom_colors.dart';

class Themes {
  Themes();
  ThemeData getThemeData() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: CustomColors.primary),
      scaffoldBackgroundColor: CustomColors.secondary,
      dividerColor: Colors.transparent,
      fontFamily: 'Nunito',
      appBarTheme: const AppBarTheme(surfaceTintColor: Colors.transparent),
    );
  }
}
