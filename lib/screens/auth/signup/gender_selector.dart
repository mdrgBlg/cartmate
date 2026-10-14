import 'package:flutter/material.dart';

import '/constants/custom_colors.dart';

class GenderSelector extends StatelessWidget {
  const GenderSelector({
    required this.value,
    required this.onChanged,
    required this.genders,
    super.key,
  });

  final String? value;
  final void Function(String?) onChanged;
  final List<String> genders;

  // Variable to hold the selected gender
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return DropdownButton<String>(
      padding: EdgeInsets.zero,
      hint: Text(
        'Gender',
        style: textTheme.bodyMedium!.copyWith(color: CustomColors.grayDark),
      ),
      underline: const Divider(color: Colors.black, height: 0),
      value: value,
      onChanged: onChanged,
      items: genders.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: textTheme.headlineSmall!.copyWith(fontSize: 16),
          ),
        );
      }).toList(),
    );
  }
}
