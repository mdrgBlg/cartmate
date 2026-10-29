import 'package:flutter/material.dart';

import '../styles/app_spacing.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: const EdgeInsets.only(left: AppSpacing.screenHorizontal),
            child: Text(widget.hintText, textAlign: TextAlign.left),
          ),
        ),
        Container(
          padding: AppSpacing.screenPadding,
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
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.sm,
              ),
              suffixIcon: IconButton(
                color: colorScheme.onSurfaceVariant,
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
