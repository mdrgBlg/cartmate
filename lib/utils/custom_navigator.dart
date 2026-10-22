import 'dart:developer';

import 'package:flutter/material.dart';

class CustomNavigator {
  CustomNavigator(this.context);
  final BuildContext context;

  Future<T?> pushNavigation<T extends Object?>({
    required Widget screen,
    String? routeName,
  }) async {
    try {
      if (context.mounted) {
        return await Navigator.push(
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
      log("Exception pushNavigation: $e", stackTrace: s);
      return null;
    }
  }

  Future<T?> pushReplacement<T extends Object?>({
    required String routeName,
    required Widget screen,
  }) async {
    try {
      if (context.mounted) {
        return await Navigator.pushReplacement(
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
      log("Exception pushReplacement: $e", stackTrace: s);
      return null;
    }
  }
}
