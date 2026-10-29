import 'package:flutter/material.dart';

import '/core/l10n/app_localizations.dart';
import '/core/styles/app_spacing.dart';
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
    this.padding = const EdgeInsets.all(AppSpacing.xl),
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
    final localization = AppLocalizations.of(context);
    return MainLayout(
      appBar: CustomAppBar(
        titleText: localization.profileChangeSection(sectionTitle),
      ),
      child: Padding(
        padding: padding,
        child: Column(
          children: [
            child,
            CustomButton(
              buttonText: localization.save,
              enable: enableSave,
              onPress: () => _onSave(context),
            ),
          ],
        ),
      ),
    );
  }

  void _onSave(BuildContext context) {
    final localization = AppLocalizations.of(context);

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
            message: localization.profileSectionChanged(sectionTitle),
          );
          onSuccess();
          Navigator.of(context).pop();
        } else {
          // Stay on the screen so the input is kept and saving can be retried.
          SnackBarPopup.showMessage(
            context,
            message: localization.somethingWentWrong,
            snackBarMessageType: SnackBarMessageType.error,
          );
        }
      },
    );
  }
}
