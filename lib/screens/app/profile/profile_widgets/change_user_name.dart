import 'package:flutter/material.dart';

import '/widgets/input_field.dart';
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

  static const routeName = '/change_user_name';

  @override
  Widget build(BuildContext context) {
    return ChangeInfoLayout(
      sectionTitle: sectionTitle,
      onSave: onSave,
      onSuccess: onSuccess,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            child: InputField(
              hintText: "First name",
              controller: firstNameController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            child: InputField(
              hintText: "Last name",
              controller: lastNameController,
            ),
          ),
        ],
      ),
    );
  }
}
