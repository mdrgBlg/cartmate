import 'package:flutter/material.dart';

import '/core/widgets/custom_app_bar.dart';
import '/core/widgets/custom_button.dart';
import '/core/widgets/layouts/main_layout.dart';
import '/utils/loading.dart';
import '/utils/snack_bar_popup.dart';

class ChangeInfoLayout extends StatelessWidget {
  const ChangeInfoLayout({
    required this.sectionTitle,
    required this.onSave,
    required this.onSuccess,
    required this.child,
    this.enableSave = true,
    this.padding = const EdgeInsets.all(20),
    super.key,
  });

  final String sectionTitle;
  final Future<bool> Function() onSave;
  final VoidCallback onSuccess;
  final Widget child;
  final bool enableSave;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBar: CustomAppBar(titleText: "Change $sectionTitle"),
      child: Padding(
        padding: padding,
        child: Column(
          children: [
            child,
            CustomButton(
              buttonText: "Save",
              enable: enableSave,
              onPress: () => _onSave(context),
            ),
          ],
        ),
      ),
    );
  }

  void _onSave(BuildContext context) {
    bool success = false;
    Loading.callLoading(
      context: context,
      callback: () async {
        success = await onSave();
      },
      onFinished: () {
        if (success) {
          SnackBarPopup.showMessage(
            context,
            message: "User successfully changed $sectionTitle",
          );
          onSuccess();
        }
        Navigator.of(context).pop();
      },
    );
  }
}
