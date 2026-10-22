import 'package:flutter/material.dart';

import '/widgets/input_field.dart';
import 'change_info_layout.dart';

class ChangeUserInfo extends StatelessWidget {
  const ChangeUserInfo({
    required this.sectionTitle,
    required this.controller,
    required this.onSave,
    required this.onSuccess,
    super.key,
  });
  final String sectionTitle;
  final TextEditingController controller;
  final Future<bool> Function() onSave;
  final void Function() onSuccess;

  @override
  Widget build(BuildContext context) {
    return ChangeInfoLayout(
      sectionTitle: sectionTitle,
      onSave: onSave,
      onSuccess: onSuccess,
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 24),
        child: InputField(hintText: sectionTitle, controller: controller),
      ),
    );
  }
}
