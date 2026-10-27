import 'package:flutter/material.dart';

import '/core/l10n/app_localizations.dart';
import '/core/widgets/input_field.dart';
import 'change_info_layout.dart';

class ChangeUserName extends StatelessWidget {
  const ChangeUserName({
    required this.sectionTitle,
    required this.onSave,
    required this.onSuccess,
    required this.firstNameController,
    required this.lastNameController,
    super.key,
  });

  final String sectionTitle;
  final Future<bool> Function() onSave;
  final VoidCallback onSuccess;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return ChangeInfoLayout(
      sectionTitle: sectionTitle,
      onSave: onSave,
      onSuccess: onSuccess,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            child: InputField(
              hintText: localization.firstName,
              controller: firstNameController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            child: InputField(
              hintText: localization.lastName,
              controller: lastNameController,
            ),
          ),
        ],
      ),
    );
  }
}
