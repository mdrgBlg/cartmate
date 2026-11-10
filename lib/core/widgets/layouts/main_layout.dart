import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({
    required this.child,
    this.bottomBar,
    this.backgroundColor,
    this.appBar,
    super.key,
  });
  final Widget child;

  // Scaffold bottom slot: floating snackbars sit above it and the body loses
  // the bottom inset. The bar handles its own bottom safe area.
  final Widget? bottomBar;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: appBar,
        bottomNavigationBar: bottomBar,
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: child,
          ),
        ),
      ),
    );
  }
}
