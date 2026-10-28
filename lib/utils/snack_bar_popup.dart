import 'package:flutter/material.dart';

import '/core/styles/custom_colors.dart';

enum SnackBarMessageType { normal, success, warning, error }

class SnackBarPopup {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showMessage(
    BuildContext context, {
    required String message,
    SnackBarMessageType snackBarMessageType = SnackBarMessageType.normal,
  }) {
    final textTheme = Theme.of(context).textTheme;
    Color getMessageBgColor() {
      switch (snackBarMessageType) {
        case SnackBarMessageType.normal:
          return CustomColors.success;
        case SnackBarMessageType.error:
          return CustomColors.error;
        case SnackBarMessageType.warning:
          return CustomColors.accent;
        default:
          return CustomColors.success;
      }
    }

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        behavior: SnackBarBehavior.floating,
        content: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: AlignmentDirectional.center,
          decoration: BoxDecoration(
            color: getMessageBgColor().withValues(alpha: 0.8),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: textTheme.titleLarge!.copyWith(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
