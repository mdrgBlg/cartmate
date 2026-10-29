import 'package:flutter/material.dart';

import '../styles/app_spacing.dart';

class InputField extends StatelessWidget {
  const InputField({
    required this.hintText,
    required this.controller,
    this.onInputChanged,
    this.height = 44,
    this.padding = AppSpacing.screenPadding,
    this.onTap,
    this.canRequestFocus = true,
    super.key,
  });

  final String hintText;
  final TextEditingController controller;
  final VoidCallback? onInputChanged;
  final double height;
  final EdgeInsets padding;
  final bool canRequestFocus;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: padding,
      child: Column(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(hintText, textAlign: TextAlign.left),
          ),
          SizedBox(
            height: height,
            child: TextFormField(
              onTap: onTap,
              canRequestFocus: canRequestFocus,
              controller: controller,
              textAlign: TextAlign.left,
              onChanged: (value) {
                if (onInputChanged != null) {
                  onInputChanged!();
                }
              },
              style: textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
