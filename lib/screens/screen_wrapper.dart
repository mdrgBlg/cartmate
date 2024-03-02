import 'package:flutter/material.dart';
import 'app_navigation.dart';

class ScreenWrapper extends StatelessWidget {
  final Widget child;
  const ScreenWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const AppNavigation(),
      body: child,
    );
  }
}
