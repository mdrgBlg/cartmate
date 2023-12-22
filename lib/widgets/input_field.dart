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
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin:
                EdgeInsets.only(left: MediaQuery.of(context).size.width / 18),
            child: Text(
              hintText,
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: controller,
            textAlign: TextAlign.center,
            obscureText: (hintText.toLowerCase() == 'password:'
                    ? true
                    : false) ||
                (hintText.toLowerCase() == 'confirm password:' ? true : false),
            onChanged: (value) {
              if (onInputChanged != null) {
                onInputChanged!();
              }
            },
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
