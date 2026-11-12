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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(localization.dateOfBirth),
        TextFormField(
          controller: dateController,
          style: textTheme.bodyLarge,
          readOnly: true,
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.calendar_today_outlined,
              size: 20,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialEntryMode: DatePickerEntryMode.calendarOnly,
              initialDate: pickedDate ?? DateTime.now(),
              firstDate: DateTime(1901),
              lastDate: DateTime.now(),
            );
            onDatePicked(date);
          },
        ),
      ],
    );
  }
}
