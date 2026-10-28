import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    required this.hintText,
    required this.controller,
    this.onInputChanged,
    this.height = 44,
    this.padding = const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: const EdgeInsets.only(left: 20),
            child: Text(hintText, textAlign: TextAlign.left),
          ),
        ),
        Container(
          padding: padding,
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
            style: textTheme.bodyLarge!.copyWith(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
