import 'package:flutter/material.dart';

import '/core/styles/app_radius.dart';
import '/core/styles/app_spacing.dart';

enum SnackBarMessageType { normal, success, warning, error }

class SnackBarPopup {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showMessage(
    BuildContext context, {
    required String message,
    SnackBarMessageType snackBarMessageType = SnackBarMessageType.normal,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final (background, foreground) = switch (snackBarMessageType) {
      SnackBarMessageType.normal || SnackBarMessageType.success => (
        colorScheme.tertiary,
        colorScheme.onTertiary,
      ),
      SnackBarMessageType.error => (colorScheme.error, colorScheme.onError),
      SnackBarMessageType.warning => (
        colorScheme.secondary,
        colorScheme.onSecondary,
      ),
    };

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        behavior: SnackBarBehavior.floating,
        content: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: AlignmentDirectional.center,
          decoration: BoxDecoration(
            color: background.withValues(alpha: 0.8),
            borderRadius: AppRadius.xlAll,
          ),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: textTheme.titleMedium!.copyWith(color: foreground),
          ),
        ),
      ),
    );
  }
}
