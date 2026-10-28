import 'package:flutter/material.dart';

import 'app_radius.dart';
import 'app_spacing.dart';
import 'app_text_theme.dart';
import 'custom_colors.dart';

class AppComponentThemes {
  AppComponentThemes._();

  static const RoundedRectangleBorder _buttonShape = RoundedRectangleBorder(
    borderRadius: AppRadius.lgAll,
  );

  static ButtonStyle get _primaryButtonStyle => ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.disabled)
          ? CustomColors.primary.withValues(alpha: 0.4)
          : CustomColors.primary,
    ),
    foregroundColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.disabled)
          ? CustomColors.onPrimary.withValues(alpha: 0.5)
          : CustomColors.onPrimary,
    ),
    elevation: const WidgetStatePropertyAll(0),
    minimumSize: const WidgetStatePropertyAll(Size(64, 49)),
    shape: const WidgetStatePropertyAll(_buttonShape),
    textStyle: WidgetStatePropertyAll(AppTextTheme.light.titleMedium),
  );

  static FilledButtonThemeData get filledButtonTheme =>
      FilledButtonThemeData(style: _primaryButtonStyle);

  static ElevatedButtonThemeData get elevatedButtonTheme =>
      ElevatedButtonThemeData(style: _primaryButtonStyle);

  static OutlinedButtonThemeData get outlinedButtonTheme =>
      OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: const WidgetStatePropertyAll(CustomColors.primary),
          side: WidgetStateProperty.resolveWith(
            (states) => BorderSide(
              color: states.contains(WidgetState.disabled)
                  ? CustomColors.grey300
                  : CustomColors.primary,
            ),
          ),
          minimumSize: const WidgetStatePropertyAll(Size(64, 49)),
          shape: const WidgetStatePropertyAll(_buttonShape),
          textStyle: WidgetStatePropertyAll(AppTextTheme.light.titleMedium),
        ),
      );

  static TextButtonThemeData get textButtonTheme => TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: const WidgetStatePropertyAll(CustomColors.primary),
      minimumSize: const WidgetStatePropertyAll(Size(64, 40)),
      shape: const WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
      ),
      textStyle: WidgetStatePropertyAll(AppTextTheme.light.labelLarge),
    ),
  );

  static const InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: CustomColors.surface,
    isDense: true,
    contentPadding: EdgeInsets.symmetric(
      horizontal: AppSpacing.lg,
      vertical: AppSpacing.md - 2,
    ),
    border: OutlineInputBorder(
      borderRadius: AppRadius.mdAll,
      borderSide: BorderSide(color: CustomColors.grey200),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: AppRadius.mdAll,
      borderSide: BorderSide(color: CustomColors.grey200),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: AppRadius.mdAll,
      borderSide: BorderSide(color: CustomColors.primary, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: AppRadius.mdAll,
      borderSide: BorderSide(color: CustomColors.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: AppRadius.mdAll,
      borderSide: BorderSide(color: CustomColors.error, width: 1.5),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: AppRadius.mdAll,
      borderSide: BorderSide(color: CustomColors.grey100),
    ),
    hintStyle: TextStyle(color: CustomColors.grey400),
    labelStyle: TextStyle(color: CustomColors.grey500),
    errorStyle: TextStyle(color: CustomColors.error),
    prefixIconColor: CustomColors.grey500,
    suffixIconColor: CustomColors.grey500,
  );

  static const CardThemeData cardTheme = CardThemeData(
    color: CustomColors.surface,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: AppRadius.lgAll,
      side: BorderSide(color: CustomColors.grey200),
    ),
  );

  static ChipThemeData get chipTheme => ChipThemeData(
    backgroundColor: CustomColors.grey100,
    selectedColor: CustomColors.primaryLight,
    side: const BorderSide(color: CustomColors.grey200),
    shape: const StadiumBorder(),
    labelStyle: AppTextTheme.light.labelLarge?.copyWith(
      color: CustomColors.text,
    ),
    secondaryLabelStyle: AppTextTheme.light.labelLarge?.copyWith(
      color: CustomColors.primary,
    ),
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
  );

  static SnackBarThemeData get snackBarTheme => SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    backgroundColor: CustomColors.grey900,
    contentTextStyle: AppTextTheme.light.bodyMedium?.copyWith(
      color: Colors.white,
    ),
    elevation: 0,
    shape: const RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
  );

  static AppBarTheme get appBarTheme => AppBarTheme(
    backgroundColor: CustomColors.primary,
    foregroundColor: CustomColors.onPrimary,
    elevation: 0,
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
    centerTitle: false,
    titleTextStyle: AppTextTheme.light.titleLarge?.copyWith(
      color: CustomColors.onPrimary,
    ),
  );

  static const DividerThemeData dividerTheme = DividerThemeData(
    color: CustomColors.grey200,
    thickness: 1,
    space: 1,
  );

  static const BottomSheetThemeData bottomSheetTheme = BottomSheetThemeData(
    backgroundColor: CustomColors.surface,
    modalBackgroundColor: CustomColors.surface,
    surfaceTintColor: Colors.transparent,
    showDragHandle: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
    ),
  );

  static const DialogThemeData dialogTheme = DialogThemeData(
    backgroundColor: CustomColors.surface,
    surfaceTintColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: AppRadius.xlAll),
  );

  static const DatePickerThemeData datePickerTheme = DatePickerThemeData(
    backgroundColor: CustomColors.surface,
    surfaceTintColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: AppRadius.xlAll),
  );

  static NavigationBarThemeData get navigationBarTheme =>
      NavigationBarThemeData(
        backgroundColor: CustomColors.surface,
        surfaceTintColor: Colors.transparent,
        indicatorColor: CustomColors.primaryLight,
        elevation: 0,
        height: 64,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => AppTextTheme.light.labelMedium?.copyWith(
            color: states.contains(WidgetState.selected)
                ? CustomColors.primary
                : CustomColors.grey500,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? CustomColors.primary
                : CustomColors.grey500,
          ),
        ),
      );
}
