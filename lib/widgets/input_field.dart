import 'package:e_commerce/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool isValid;
  final VoidCallback? onInputChanged;
  const InputField({
    super.key,
    required this.hintText,
    required this.isValid,
    this.onInputChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: const EdgeInsets.only(left: 20),
            child: Text(
              hintText,
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: 48,
          child: TextFormField(
            controller: controller,
            textAlign: TextAlign.center,
            obscureText: (hintText.toLowerCase() == 'password:' ? true : false) || (hintText.toLowerCase() == 'confirm password:' ? true : false),
            onChanged: (value) {
              if (onInputChanged != null) {
                onInputChanged!();
              }
            },
            style: textTheme.bodyMedium!.copyWith(),
            decoration: const InputDecoration(
              floatingLabelAlignment: FloatingLabelAlignment.center,
              alignLabelWithHint: true,
            ),
          ),
        )
      ],
    );
  }
}
