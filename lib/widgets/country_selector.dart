import 'package:country_picker/country_picker.dart';
import 'package:e_commerce/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class CountrySelector extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Function(Country)? onSelect;
  final double height;
  final EdgeInsets padding;
  const CountrySelector({
    super.key,
    required this.hintText,
    required this.controller,
    this.onSelect,
    this.height = 44,
    this.padding = const EdgeInsets.fromLTRB(20, 0, 20, 0),
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => showCountryPicker(
        context: context,
        onSelect: onSelect ?? (value) {},
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 18,
          left: 20,
          right: 20,
        ),
        child: Container(
          height: height,
          width: double.infinity,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: CustomColors.grayDark,
              ),
            ),
          ),
          child: Text(
            controller.text.toString(),
            style: textTheme.headlineSmall!.copyWith(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
