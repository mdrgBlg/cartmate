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

  // Dark inverseSurface stays a dark elevated shade so dark app bars and
  // badges keep light text.
  static const ColorScheme _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: CustomColors.darkPrimary,
    onPrimary: CustomColors.darkOnPrimary,
    primaryContainer: CustomColors.darkPrimaryContainer,
    onPrimaryContainer: CustomColors.primaryLight,
    secondary: CustomColors.darkAccent,
    onSecondary: CustomColors.onAccent,
    secondaryContainer: Color(0xFF78350F),
    onSecondaryContainer: CustomColors.accentLight,
    tertiary: Color(0xFF34D399),
    onTertiary: Color(0xFF064E3B),
    tertiaryContainer: Color(0xFF065F46),
    onTertiaryContainer: Color(0xFFD1FAE5),
    error: Color(0xFFF87171),
    onError: Color(0xFF450A0A),
    errorContainer: Color(0xFF7F1D1D),
    onErrorContainer: Color(0xFFFEE2E2),
    surface: CustomColors.darkSurface,
    onSurface: CustomColors.darkOnSurface,
    onSurfaceVariant: CustomColors.grey400,
    outline: CustomColors.grey500,
    outlineVariant: CustomColors.darkOutlineVariant,
    surfaceTint: Colors.transparent,
    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: CustomColors.darkSurfaceContainerHighest,
    onInverseSurface: CustomColors.grey100,
    inversePrimary: CustomColors.primary,
    surfaceContainerLowest: CustomColors.darkBackground,
    surfaceContainerLow: CustomColors.darkSurfaceContainerLow,
    surfaceContainer: CustomColors.darkSurfaceContainer,
    surfaceContainerHigh: CustomColors.darkSurfaceContainerHigh,
    surfaceContainerHighest: CustomColors.darkSurfaceContainerHighest,
  );

  ThemeData getThemeData() => _build(
    scheme: _lightColorScheme,
    scaffold: CustomColors.background,
    textTheme: AppTextTheme.light,
  );

  ThemeData getDarkThemeData() => _build(
    scheme: _darkColorScheme,
    scaffold: CustomColors.darkBackground,
    textTheme: AppTextTheme.dark,
  );

  ThemeData _build({
    required ColorScheme scheme,
    required Color scaffold,
    required TextTheme textTheme,
  }) {
    return ThemeData(
      useMaterial3: true,
      brightness: scheme.brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scaffold,
      canvasColor: scheme.surface,
      fontFamily: AppTextTheme.fontFamily,
      textTheme: textTheme,
      dividerColor: Colors.transparent,
      filledButtonTheme: AppComponentThemes.filledButtonTheme(scheme),
      elevatedButtonTheme: AppComponentThemes.elevatedButtonTheme(scheme),
      outlinedButtonTheme: AppComponentThemes.outlinedButtonTheme(scheme),
      textButtonTheme: AppComponentThemes.textButtonTheme(scheme),
      inputDecorationTheme: AppComponentThemes.inputDecorationTheme(scheme),
      cardTheme: AppComponentThemes.cardTheme(scheme),
      chipTheme: AppComponentThemes.chipTheme(scheme),
      snackBarTheme: AppComponentThemes.snackBarTheme(scheme),
      appBarTheme: AppComponentThemes.appBarTheme(scheme),
      dividerTheme: AppComponentThemes.dividerTheme(scheme),
      bottomSheetTheme: AppComponentThemes.bottomSheetTheme(scheme),
      dialogTheme: AppComponentThemes.dialogTheme(scheme),
      datePickerTheme: AppComponentThemes.datePickerTheme(scheme),
      navigationBarTheme: AppComponentThemes.navigationBarTheme(scheme),
    );
  }
}
