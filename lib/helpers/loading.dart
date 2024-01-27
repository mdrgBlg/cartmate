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
    //final localization = AppLocalizations.of(context)!;
    showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (_) => PopScope(
        canPop: false,
        child: Center(
          child: Container(
            color: Colors.black.withOpacity(0.3),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitThreeInOut(
                  color: CustomColors.primary,
                  size: 36.0,
                ),
                SizedBox(height: 12),
                Text(
                  "Loading...",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
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
