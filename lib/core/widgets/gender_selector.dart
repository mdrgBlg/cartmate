import 'package:flutter/material.dart';

import '/core/l10n/app_localizations.dart';
import '/utils/global_enums.dart';

class GenderSelector extends StatelessWidget {
  const GenderSelector({
    required this.initialGender,
    required this.onChanged,
    required this.genders,
    super.key,
  });

  final Gender? initialGender;
  final void Function(Gender?) onChanged;
  final List<Gender> genders;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(localization.gender),
        DropdownButtonFormField<Gender>(
          initialValue: initialGender,
          isExpanded: true,
          style: textTheme.bodyLarge,
          onChanged: onChanged,
          items: genders
              .map(
                (gender) => DropdownMenuItem<Gender>(
                  value: gender,
                  child: Text(gender.genderName(localization)),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
