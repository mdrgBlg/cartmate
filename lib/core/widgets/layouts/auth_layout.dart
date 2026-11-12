import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../styles/app_radius.dart';
import '../../styles/app_shadows.dart';
import '../../styles/app_spacing.dart';
import '../../styles/custom_colors.dart';
import 'auth_header.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({
    required this.title,
    required this.child,
    super.key,
    this.subtitle,
    this.headerAction,
    this.showBackButton = false,
  });

  final String title;
  final String? subtitle;

  /// Content rendered inside the card below the header.
  final Widget child;

  /// Widget in the header's top-right corner (e.g. the "Sign up" link).
  final Widget? headerAction;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    final statusBarHeight = MediaQuery.paddingOf(context).top;

    // Slightly deeper end color; in dark it stays light enough for onPrimary.
    final gradientEnd = isDark
        ? Color.lerp(colorScheme.primary, colorScheme.primaryContainer, 0.15)!
        : CustomColors.primaryDark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      // The status bar strip below is primary coloured: light primary in
      // dark mode needs dark icons, indigo in light mode needs light icons.
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.dark : Brightness.light,
        statusBarBrightness: isDark ? Brightness.light : Brightness.dark,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(child: Container(color: gradientEnd)),
                Expanded(child: Container(color: Colors.white)),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.viewInsetsOf(context).bottom,
              ),
              child: Column(
                children: [
                  // Pinned OUTSIDE the scroll view: when the header scrolls away
                  // (sign up with the keyboard open) the status bar icons keep a
                  // primary background instead of the page color, and an iOS
                  // top overscroll never exposes the page color behind them.
                  ColoredBox(
                    color: colorScheme.primary,
                    child: SizedBox(
                      height: statusBarHeight,
                      width: double.infinity,
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      child: SingleChildScrollView(
                        // Default left/right/bottom insets stay on (landscape
                        // notch on iOS); top is the strip above.
                        child: SafeArea(
                          top: false,
                          child: Column(
                            children: [
                              AuthHeader(
                                title: title,
                                subtitle: subtitle,
                                action: headerAction,
                                showBackButton: showBackButton,
                              ),
                              _AuthCard(child: child),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthCard extends StatelessWidget {
  const _AuthCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: AppSpacing.screenPadding,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: AppRadius.xxlAll,
          boxShadow: AppShadows.cardFor(colorScheme),
        ),
        // Real Material so InkWells inside the card paint their ink on it.
        child: Material(
          color: colorScheme.surface,
          borderRadius: AppRadius.xxlAll,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xxl,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
