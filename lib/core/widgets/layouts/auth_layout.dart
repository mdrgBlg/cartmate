import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../styles/app_radius.dart';
import '../../styles/app_shadows.dart';
import '../../styles/app_spacing.dart';
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

  // The card is pulled up by this much over the header. Transform.translate
  // only moves the paint and hit-test position; the layout box keeps the
  // card's full height. Taps in the overlapped strip DO reach the card
  // (RenderTransform does not clip hit tests to its own bounds, the Column
  // hit-tests the later child, the card, first, and the strip is inside the
  // Column's bounds). Keeping the overlap <= the card's inner top padding
  // (below) is therefore only a VISUAL rule: no card content is drawn over
  // the header.
  static const double _cardOverlap = AppSpacing.xxl;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    final statusBarHeight = MediaQuery.paddingOf(context).top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      // The status bar strip below is primary coloured: light primary in
      // dark mode needs dark icons, indigo in light mode needs light icons.
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.dark : Brightness.light,
        statusBarBrightness: isDark ? Brightness.light : Brightness.dark,
      ),
      child: Scaffold(
        body: Column(
          children: [
            // Pinned OUTSIDE the scroll view: when the header scrolls away
            // (sign up with the keyboard open) the status bar icons keep a
            // primary background instead of the page colour, and an iOS
            // top overscroll never exposes the page colour behind them.
            ColoredBox(
              color: colorScheme.primary,
              child: SizedBox(height: statusBarHeight, width: double.infinity),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
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
                          cardOverlap: _cardOverlap,
                        ),
                        Transform.translate(
                          offset: const Offset(0, -_cardOverlap),
                          child: _AuthCard(child: child),
                        ),
                        // The layout box still has the card's full height,
                        // so ~24 dp of empty space remains under the
                        // shifted card: the real bottom gap is about
                        // 24 + 8 dp. If it looks too large, shrink this
                        // SizedBox or drop it.
                        const SizedBox(height: AppSpacing.sm),
                      ],
                    ),
                  ),
                ),
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
