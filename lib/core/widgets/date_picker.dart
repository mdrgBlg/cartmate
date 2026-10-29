import 'package:flutter/material.dart';

import '/core/l10n/app_localizations.dart';

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
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return TextField(
      controller: dateController,
      style: textTheme.bodyLarge,
      decoration: InputDecoration(
        filled: false,
        contentPadding: EdgeInsets.zero,
        label: Padding(
          padding: const EdgeInsets.only(top: 18),
          child: Text(
            dateController.text.isEmpty ? localization.dateOfBirth : "",
            style: textTheme.bodyMedium!.copyWith(
              color: pickedDate == null
                  ? colorScheme.onSurfaceVariant
                  : colorScheme.primary,
            ),
          ),
        ),
        iconColor: pickedDate == null
            ? colorScheme.onSurfaceVariant
            : colorScheme.primary,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: pickedDate == null
                ? colorScheme.outline
                : colorScheme.onSurface,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: pickedDate == null
                ? colorScheme.outline
                : colorScheme.primary,
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
        );
        onDatePicked(pickedDate);
      },
    );
  }
}
