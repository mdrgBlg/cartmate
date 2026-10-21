import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../screens/app_navigation.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({
    required this.child,
    this.showNavBar = false,
    this.backgroundColor,
    this.appBar,
    super.key,
  });
  final bool showNavBar;
  final Widget child;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        appBar: appBar,
        bottomNavigationBar: showNavBar ? const AppNavigation() : null,
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: child,
          ),
        ),
      ),
    );
  }
}
