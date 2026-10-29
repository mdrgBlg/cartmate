import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '/core/l10n/app_localizations.dart';
import '/core/styles/custom_colors.dart';

class Loading {
  static Future<void> callLoading({
    required BuildContext context,
    required Future<void> Function() callback,
    VoidCallback? onFinished,
  }) async {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final localization = AppLocalizations.of(context);
    // showDialog pushes onto the root navigator, so the same one must pop it.
    final navigator = Navigator.of(context, rootNavigator: true);

    showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (_) => PopScope(
        canPop: false,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SpinKitThreeInOut(color: colorScheme.primary, size: 36.0),
              const SizedBox(height: 12),
              Text(
                localization.loading,
                style: textTheme.bodyLarge?.copyWith(
                  color: CustomColors.onScrim,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    try {
      await callback();
    } finally {
      if (navigator.mounted) {
        navigator.pop();
      }
    }

    onFinished?.call();
  }
}
