import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final VoidCallback? onInputChanged;
  const InputField({
    super.key,
    required this.hintText,
    required this.controller,
    this.onInputChanged,
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
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          height: 44,
          child: TextFormField(
            controller: controller,
            textAlign: TextAlign.left,
            onChanged: (value) {
              if (onInputChanged != null) {
                onInputChanged!();
              }
            },
            style: textTheme.headlineSmall!.copyWith(fontSize: 16),
          ),
        )
      ],
    );
  }
}
