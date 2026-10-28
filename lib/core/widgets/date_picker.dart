import 'package:flutter/material.dart';

import '/core/l10n/app_localizations.dart';
import '../styles/custom_colors.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({
    required this.onDatePicked,
    required this.dateController,
    required this.pickedDate,
    super.key,
  });

  final TextEditingController dateController;
  final void Function(DateTime?) onDatePicked;
  final DateTime? pickedDate;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return TextField(
      controller: dateController,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        filled: false,
        contentPadding: EdgeInsets.zero,
        label: Padding(
          padding: const EdgeInsets.only(top: 18),
          child: Text(
            dateController.text.isEmpty ? localization.dateOfBirth : "",
            style: TextStyle(
              color: pickedDate == null
                  ? CustomColors.grayDark
                  : CustomColors.primary,
              fontSize: 14,
            ),
          ),
        ),
        iconColor: pickedDate == null
            ? CustomColors.grayDark
            : CustomColors.primary,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: pickedDate == null ? CustomColors.grayDark : Colors.black,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: pickedDate == null
                ? CustomColors.grayDark
                : CustomColors.primary,
          ),
        ),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: this.pickedDate ?? DateTime.now(),
          firstDate: DateTime(1901),
          lastDate: DateTime.now(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: CustomColors.primary,
                ),
              ),
              child: child!,
            );
          },
        );
        onDatePicked(pickedDate);
      },
    );
  }
}
