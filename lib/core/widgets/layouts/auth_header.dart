import 'package:flutter/material.dart';

import '/utils/assets/custom_icons.dart';
import '../../styles/app_spacing.dart';
import '../../styles/custom_colors.dart';

/// Gradient header shared by the auth screens: toolbar row (back button
/// and/or [action]), logo, [title] and optional [subtitle].
class AuthHeader extends StatelessWidget {
  const AuthHeader({
    required this.title,
    required this.cardOverlap,
    super.key,
    this.subtitle,
    this.action,
    this.showBackButton = false,
  });

  final String title;
  final String? subtitle;

  /// Aligned to the top-right of the toolbar row (e.g. the "Sign up" link).
  final Widget? action;
  final bool showBackButton;

  /// How far the card below is pulled up over this header.
  final double cardOverlap;

  static const double _toolbarHeight = 48;
  static const double _logoWidth = 64;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    // Slightly deeper end colour; in dark it stays light enough for onPrimary.
    final gradientEnd = isDark
        ? Color.lerp(colorScheme.primary, colorScheme.primaryContainer, 0.15)!
        : CustomColors.primaryDark;

    return DecoratedBox(
      decoration: BoxDecoration(
        // Vertical, so the top edge is exactly `primary` and meets the
        // status bar strip pinned by AuthLayout without a visible seam.
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [colorScheme.primary, gradientEnd],
        ),
      ),
      // Transparent Material so ink effects of the action/back button are
      // painted above the gradient, not hidden below it.
      child: Material(
        type: MaterialType.transparency,
        child: Padding(
          // No top padding: the status bar inset is handled by the pinned
          // strip in AuthLayout, outside the scroll view.
          padding: EdgeInsets.only(bottom: cardOverlap + AppSpacing.lg),
          child: Column(
            children: [
              SizedBox(
                height: _toolbarHeight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                  ),
                  child: Row(
                    children: [
                      if (showBackButton)
                        BackButton(color: colorScheme.onPrimary),
                      const Spacer(),
                      ?action,
                    ],
                  ),
                ),
              ),
              Image.asset(CustomIcons.cartIcon, width: _logoWidth),
              const SizedBox(height: AppSpacing.md),
              Padding(
                padding: AppSpacing.screenPadding,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: textTheme.headlineSmall!.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
              if (subtitle != null)
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppSpacing.screenHorizontal,
                    right: AppSpacing.screenHorizontal,
                    top: AppSpacing.xs,
                  ),
                  child: Text(
                    subtitle!,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium!.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
