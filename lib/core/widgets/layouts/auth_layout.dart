import 'package:flutter/material.dart';

import '../../styles/custom_colors.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({
    required this.child,
    super.key,
    this.showAppBar = true,
    this.backgroundColor,
    this.cardMargin = const EdgeInsets.symmetric(horizontal: 32),
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
    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              toolbarHeight: 52,
              backgroundColor: CustomColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
            )
          : null,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Column(
                children: [
                  Expanded(child: Container(color: CustomColors.primary)),
                  Expanded(child: Container(color: Colors.white)),
                ],
              ),
              ...overlays,
              Card(
                margin: cardMargin,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 3,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 24,
                  ),
                  child: SingleChildScrollView(child: child),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
