import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/core/styles/custom_colors.dart';
import '/utils/assets/custom_icons.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  static const double _logoWidth = 120;

  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _scale = Tween<double>(
      begin: 0.94,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.stop();
      _controller.value = 1;
    } else if (!_controller.isAnimating) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Follows the OS setting, like the native splash (which cannot read the
    // in-app theme choice). Colours must match flutter_native_splash in
    // pubspec.yaml: CustomColors.primary / CustomColors.darkBackground.
    final isDark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      // Light icons suit both splash backgrounds (#4F46E5 and #0F1020).
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: isDark
            ? CustomColors.darkBackground
            : CustomColors.primary,
        body: Center(
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            builder: (_, opacity, child) =>
                Opacity(opacity: opacity, child: child),
            child: ScaleTransition(
              scale: _scale,
              child: Image.asset(CustomIcons.cartIcon, width: _logoWidth),
            ),
          ),
        ),
      ),
    );
  }
}
