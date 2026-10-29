import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../styles/app_radius.dart';
import '../../styles/app_spacing.dart';
import '../custom_app_bar.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({
    required this.child,
    super.key,
    this.showAppBar = true,
    this.backgroundColor,
    this.cardMargin = const EdgeInsets.symmetric(horizontal: AppSpacing.xxxl),
    this.overlays = const [],
  });

  /// Content rendered inside the centered card.
  final Widget child;
  final bool showAppBar;
  final Color? backgroundColor;
  final EdgeInsetsGeometry cardMargin;

  /// Extra widgets (usually [Positioned]) stacked above the background.
  final List<Widget> overlays;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: showAppBar ? const CustomAppBar() : null,
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: true,
        extendBody: true,
        body: SafeArea(
          top: !showAppBar,
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Column(
                  children: [
                    Expanded(child: Container(color: colorScheme.primary)),
                    Expanded(
                      child: Container(
                        color: colorScheme.surfaceContainerLowest,
                      ),
                    ),
                  ],
                ),
                ...overlays,
                Card(
                  margin: cardMargin,
                  shape: const RoundedRectangleBorder(
                    borderRadius: AppRadius.lgAll,
                  ),
                  elevation: 3,
                  color: colorScheme.surface,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xxl,
                    ),
                    child: SingleChildScrollView(child: child),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
