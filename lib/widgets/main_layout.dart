import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../screens/app_navigation.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({required this.child, this.backgroundColor, super.key});
  final Color? backgroundColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        bottomNavigationBar: const AppNavigation(),
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
