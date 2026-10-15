import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants/custom_colors.dart';

class Loading {
  static callLoading({
    required BuildContext context,
    required Function callback,
    Function? onFinished,
    bool barrierDismissible = false,
  }) async {
    final textTheme = Theme.of(context).textTheme;
    showDialog<void>(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (_) => PopScope(
        canPop: false,
        child: Center(
          child: Container(
            color: Colors.black.withValues(alpha: 0.3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SpinKitThreeInOut(
                  color: CustomColors.primary,
                  size: 36.0,
                ),
                const SizedBox(height: 12),
                Text(
                  "Loading...",
                  style: textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    await callback();

    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();

    if (onFinished != null) {
      onFinished();
    }
  }
}
