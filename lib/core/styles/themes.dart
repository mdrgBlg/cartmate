import 'package:flutter/material.dart';

import 'app_text_theme.dart';
import 'component_themes.dart';
import 'custom_colors.dart';

class Themes {
  Themes();

  static const ColorScheme _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: CustomColors.primary,
    onPrimary: CustomColors.onPrimary,
    primaryContainer: CustomColors.primaryLight,
    onPrimaryContainer: Color(0xFF312E81),
    secondary: CustomColors.accent,
    onSecondary: CustomColors.onAccent,
    secondaryContainer: CustomColors.accentLight,
    onSecondaryContainer: Color(0xFF78350F),
    tertiary: CustomColors.success,
    onTertiary: Colors.white,
    tertiaryContainer: Color(0xFFD1FAE5),
    onTertiaryContainer: Color(0xFF064E3B),
    error: CustomColors.error,
    onError: Colors.white,
    errorContainer: Color(0xFFFEE2E2),
    onErrorContainer: Color(0xFF7F1D1D),
    surface: CustomColors.surface,
    onSurface: CustomColors.grey900,
    onSurfaceVariant: CustomColors.grey500,
    outline: CustomColors.grey400,
    outlineVariant: CustomColors.grey200,
    surfaceTint: Colors.transparent,
    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: CustomColors.grey900,
    onInverseSurface: Colors.white,
    inversePrimary: Color(0xFFA5B4FC),
    surfaceContainerLowest: CustomColors.surface,
    surfaceContainerLow: CustomColors.grey50,
    surfaceContainer: CustomColors.grey100,
    surfaceContainerHigh: CustomColors.grey100,
    surfaceContainerHighest: CustomColors.grey200,
  );

  ThemeData getThemeData() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: _lightColorScheme,
      scaffoldBackgroundColor: CustomColors.background,
      canvasColor: CustomColors.surface,
      fontFamily: AppTextTheme.fontFamily,
      textTheme: AppTextTheme.light,
      dividerColor: Colors.transparent,
      filledButtonTheme: AppComponentThemes.filledButtonTheme,
      elevatedButtonTheme: AppComponentThemes.elevatedButtonTheme,
      outlinedButtonTheme: AppComponentThemes.outlinedButtonTheme,
      textButtonTheme: AppComponentThemes.textButtonTheme,
      inputDecorationTheme: AppComponentThemes.inputDecorationTheme,
      cardTheme: AppComponentThemes.cardTheme,
      chipTheme: AppComponentThemes.chipTheme,
      snackBarTheme: AppComponentThemes.snackBarTheme,
      appBarTheme: AppComponentThemes.appBarTheme,
      dividerTheme: AppComponentThemes.dividerTheme,
      bottomSheetTheme: AppComponentThemes.bottomSheetTheme,
      dialogTheme: AppComponentThemes.dialogTheme,
      datePickerTheme: AppComponentThemes.datePickerTheme,
      navigationBarTheme: AppComponentThemes.navigationBarTheme,
    );
  }
}
