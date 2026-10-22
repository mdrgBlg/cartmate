import 'package:flutter/material.dart';

import '/utils/global_enums.dart';
import '/utils/constants/custom_colors.dart';

class GenderSelector extends StatefulWidget {
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
  State<GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  Gender? _selectedGender;
  @override
  void initState() {
    super.initState();
    _selectedGender = widget.initialGender;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return DropdownButton<Gender>(
      padding: EdgeInsets.zero,
      hint: Text(
        'Gender',
        style: textTheme.bodyMedium!.copyWith(color: CustomColors.grayDark),
      ),
      underline: const Divider(color: Colors.black, height: 0),
      value: _selectedGender,
      onChanged: (value) {
        setState(() => _selectedGender = value);
        widget.onChanged(value);
      },
      items: widget.genders.map<DropdownMenuItem<Gender>>((Gender value) {
        return DropdownMenuItem<Gender>(
          value: value,
          child: Text(
            value.genderName(),
            style: textTheme.headlineSmall!.copyWith(fontSize: 16),
          ),
        );
      }).toList(),
    );
  }
}
