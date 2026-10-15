import 'package:flutter/material.dart';

class CustomNavigator {
  CustomNavigator(this.context);
  final BuildContext context;

  ///TODO ADD LOGGER
  Future<T?> pushNavigation<T extends Object?>({
    required String routeName,
    required Widget screen,
  }) async {
    try {
      if (context.mounted) {
        return Navigator.push(
          context,
          MaterialPageRoute<T>(
            settings: RouteSettings(name: routeName),
            builder: (_) => screen,
          ),
        );
      } else {
        return null;
      }
    } catch (e, s) {
      return null;
    }
  }

  ///TODO ADD LOGGER
  Future<T?> pushReplacement<T extends Object?>({
    required String routeName,
    required Widget screen,
  }) async {
    try {
      if (context.mounted) {
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute<T>(
            settings: RouteSettings(name: routeName),
            builder: (_) => screen,
          ),
        );
      } else {
        return null;
      }
    } catch (e, s) {
      return null;
    }
  }
}
