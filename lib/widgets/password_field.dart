import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool isValid;
  final VoidCallback? onInputChanged;
  final bool passwordVisibility;
  final VoidCallback changeVisibility;
  const PasswordField({
    super.key,
    required this.hintText,
    required this.isValid,
    this.onInputChanged,
    this.controller,
    required this.passwordVisibility,
    required this.changeVisibility,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: const EdgeInsets.only(
              left: 20,
            ),
            child: Text(
              hintText,
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
          height: 44,
          child: TextFormField(
            controller: controller,
            textAlign: TextAlign.left,
            obscureText: passwordVisibility,
            onChanged: (value) {
              if (onInputChanged != null) {
                onInputChanged!();
              }
            },
            style: textTheme.headlineSmall!.copyWith(),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                color: Colors.black,
                padding: const EdgeInsets.only(bottom: 4),
                alignment: Alignment.centerRight,
                icon: Icon(
                  passwordVisibility ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () => changeVisibility(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
