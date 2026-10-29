import 'package:flutter/material.dart';

import '/core/styles/app_spacing.dart';
import '/core/widgets/date_picker.dart';
import '/utils/extensions/date_time_extension.dart';
import 'change_info_layout.dart';

class ChangeDateOfBirth extends StatefulWidget {
  const ChangeDateOfBirth({
    required this.sectionTitle,
    required this.initialDate,
    required this.onSave,
    required this.onSuccess,
    super.key,
  });

  final String sectionTitle;
  final DateTime? initialDate;
  final Future<bool> Function(DateTime date) onSave;
  final void Function(DateTime date) onSuccess;

  @override
  State<ChangeDateOfBirth> createState() => _ChangeDateOfBirthState();
}

class _ChangeDateOfBirthState extends State<ChangeDateOfBirth> {
  late final TextEditingController _dateController;
  DateTime? _pickedDate;

  @override
  void initState() {
    super.initState();
    _pickedDate = widget.initialDate;
    _dateController = TextEditingController(
      text: _pickedDate?.formatDateTime(),
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  void _onDatePicked(DateTime? date) {
    if (date == null) {
      return;
    }
    setState(() {
      _pickedDate = date;
      _dateController.text = date.formatDateTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeInfoLayout(
      sectionTitle: widget.sectionTitle,
      enableSave: _pickedDate != null,
      onSave: () => widget.onSave(_pickedDate!),
      onSuccess: () => widget.onSuccess(_pickedDate!),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: AppSpacing.xxl,
          left: AppSpacing.screenHorizontal,
          right: AppSpacing.screenHorizontal,
        ),
        child: DatePicker(
          dateController: _dateController,
          pickedDate: _pickedDate,
          onDatePicked: _onDatePicked,
        ),
      ),
    );
  }
}
