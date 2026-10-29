import 'package:flutter/material.dart';

import 'app_radius.dart';
import 'app_spacing.dart';
import 'app_text_theme.dart';

// Text styles use AppTextTheme.light, which is colorless, so they are
// brightness-neutral; colors come from the given ColorScheme.
class AppComponentThemes {
  AppComponentThemes._();

  static const RoundedRectangleBorder _buttonShape = RoundedRectangleBorder(
    borderRadius: AppRadius.lgAll,
  );

  static ButtonStyle _primaryButtonStyle(ColorScheme scheme) => ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.disabled)
          ? scheme.primary.withValues(alpha: 0.4)
          : scheme.primary,
    ),
    foregroundColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.disabled)
          ? scheme.onPrimary.withValues(alpha: 0.5)
          : scheme.onPrimary,
    ),
    elevation: const WidgetStatePropertyAll(0),
    minimumSize: const WidgetStatePropertyAll(Size(64, 49)),
    shape: const WidgetStatePropertyAll(_buttonShape),
    textStyle: WidgetStatePropertyAll(AppTextTheme.light.titleMedium),
  );

  static FilledButtonThemeData filledButtonTheme(ColorScheme scheme) =>
      FilledButtonThemeData(style: _primaryButtonStyle(scheme));

  static ElevatedButtonThemeData elevatedButtonTheme(ColorScheme scheme) =>
      ElevatedButtonThemeData(style: _primaryButtonStyle(scheme));

  static OutlinedButtonThemeData outlinedButtonTheme(ColorScheme scheme) =>
      OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(scheme.primary),
          side: WidgetStateProperty.resolveWith(
            (states) => BorderSide(
              color: states.contains(WidgetState.disabled)
                  ? scheme.outlineVariant
                  : scheme.primary,
            ),
          ),
          minimumSize: const WidgetStatePropertyAll(Size(64, 49)),
          shape: const WidgetStatePropertyAll(_buttonShape),
          textStyle: WidgetStatePropertyAll(AppTextTheme.light.titleMedium),
        ),
      );

  static TextButtonThemeData textButtonTheme(ColorScheme scheme) =>
      TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(scheme.primary),
          minimumSize: const WidgetStatePropertyAll(Size(64, 40)),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
          ),
          textStyle: WidgetStatePropertyAll(AppTextTheme.light.labelLarge),
        ),
      );

  static InputDecorationTheme inputDecorationTheme(ColorScheme scheme) =>
      InputDecorationTheme(
        filled: true,
        fillColor: scheme.surface,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md - 2,
        ),
        border: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: BorderSide(color: scheme.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: BorderSide(color: scheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: BorderSide(color: scheme.error, width: 1.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: BorderSide(color: scheme.surfaceContainer),
        ),
        hintStyle: TextStyle(color: scheme.outline),
        labelStyle: TextStyle(color: scheme.onSurfaceVariant),
        errorStyle: TextStyle(color: scheme.error),
        prefixIconColor: scheme.onSurfaceVariant,
        suffixIconColor: scheme.onSurfaceVariant,
      );

  static CardThemeData cardTheme(ColorScheme scheme) => CardThemeData(
    color: scheme.surface,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: AppRadius.lgAll,
      side: BorderSide(color: scheme.outlineVariant),
    ),
  );

  static ChipThemeData chipTheme(ColorScheme scheme) => ChipThemeData(
    backgroundColor: scheme.surfaceContainer,
    selectedColor: scheme.primaryContainer,
    side: BorderSide(color: scheme.outlineVariant),
    shape: const StadiumBorder(),
    labelStyle: AppTextTheme.light.labelLarge?.copyWith(
      color: scheme.onSurface,
    ),
    secondaryLabelStyle: AppTextTheme.light.labelLarge?.copyWith(
      color: scheme.primary,
    ),
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
  );

  static SnackBarThemeData snackBarTheme(ColorScheme scheme) =>
      SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: scheme.inverseSurface,
        contentTextStyle: AppTextTheme.light.bodyMedium?.copyWith(
          color: scheme.onInverseSurface,
        ),
        elevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
      );

  static AppBarTheme appBarTheme(ColorScheme scheme) => AppBarTheme(
    backgroundColor: scheme.primary,
    foregroundColor: scheme.onPrimary,
    elevation: 0,
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
    centerTitle: false,
    titleTextStyle: AppTextTheme.light.titleLarge?.copyWith(
      color: scheme.onPrimary,
    ),
  );

  static DividerThemeData dividerTheme(ColorScheme scheme) =>
      DividerThemeData(color: scheme.outlineVariant, thickness: 1);

  static BottomSheetThemeData bottomSheetTheme(ColorScheme scheme) =>
      BottomSheetThemeData(
        backgroundColor: scheme.surface,
        modalBackgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        showDragHandle: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.xl),
          ),
        ),
      );

  static DialogThemeData dialogTheme(ColorScheme scheme) => DialogThemeData(
    backgroundColor: scheme.surface,
    surfaceTintColor: Colors.transparent,
    shape: const RoundedRectangleBorder(borderRadius: AppRadius.xlAll),
  );

  static DatePickerThemeData datePickerTheme(ColorScheme scheme) =>
      DatePickerThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.xlAll),
      );

  static NavigationBarThemeData navigationBarTheme(ColorScheme scheme) =>
      NavigationBarThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        indicatorColor: scheme.primaryContainer,
        elevation: 0,
        height: 64,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => AppTextTheme.light.labelMedium?.copyWith(
            color: states.contains(WidgetState.selected)
                ? scheme.primary
                : scheme.onSurfaceVariant,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? scheme.primary
                : scheme.onSurfaceVariant,
          ),
        ),
      );
}
