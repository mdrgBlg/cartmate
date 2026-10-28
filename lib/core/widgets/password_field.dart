import 'package:flutter/material.dart';

import '../styles/custom_colors.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    required this.hintText,
    this.onInputChanged,
    this.controller,
    super.key,
  });

  final TextEditingController? controller;
  final String hintText;
  final VoidCallback? onInputChanged;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() => _obscureText = !_obscureText);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: const EdgeInsets.only(left: 20),
            child: Text(widget.hintText, textAlign: TextAlign.left),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
          height: 44,
          child: TextFormField(
            controller: widget.controller,
            textAlign: TextAlign.left,
            obscureText: _obscureText,
            onChanged: (value) {
              if (widget.onInputChanged != null) {
                widget.onInputChanged!();
              }
            },

            style: textTheme.bodyLarge!.copyWith(fontSize: 18),
            decoration: InputDecoration(
              isDense: true,
              suffixIcon: IconButton(
                color: CustomColors.grey500,
                iconSize: 20,
                padding: EdgeInsets.zero,
                splashRadius: 16,
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: _toggleVisibility,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
