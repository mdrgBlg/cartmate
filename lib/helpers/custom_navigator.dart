import 'package:flutter/material.dart';

class CustomNavigator {
  static void pushNavigation({
    required BuildContext context,
    required String routeName,
    required Widget screen,
  }) {
    Navigator.push(
      context,
      PageRouteBuilder(
        settings: RouteSettings(name: routeName),
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  static void pushReplacement({
    required BuildContext context,
    required String routeName,
    required Widget screen,
  }) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        settings: RouteSettings(name: routeName),
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }
}
