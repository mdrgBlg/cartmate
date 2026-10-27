import 'package:flutter/material.dart';

import '/core/widgets/gender_selector.dart';
import '/utils/global_enums.dart';
import 'change_info_layout.dart';

class ChangeGender extends StatefulWidget {
  const ChangeGender({
    required this.sectionTitle,
    required this.initialGender,
    required this.onSave,
    required this.onSuccess,
    super.key,
  });

  final String sectionTitle;
  final Gender? initialGender;
  final Future<bool> Function(Gender gender) onSave;
  final void Function(Gender gender) onSuccess;

  @override
  State<ChangeGender> createState() => _ChangeGenderState();
}

class _ChangeGenderState extends State<ChangeGender> {
  Gender? _selectedGender;
  @override
  Widget build(BuildContext context) {
    return ChangeInfoLayout(
      sectionTitle: widget.sectionTitle,
      enableSave: _selectedGender != null,
      padding: EdgeInsets.zero,
      onSave: () => widget.onSave(_selectedGender!),
      onSuccess: () => widget.onSuccess(_selectedGender!),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: GenderSelector(
          initialGender: widget.initialGender,
          genders: Gender.values,
          onChanged: (value) => setState(() => _selectedGender = value),
        ),
      ),
    );
  }
}
