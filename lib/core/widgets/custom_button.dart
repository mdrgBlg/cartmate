import 'package:flutter/material.dart';

import '../styles/app_radius.dart';
import '../styles/app_spacing.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.buttonText,
    required this.enable,
    this.onPress,
    this.margin = AppSpacing.screenPadding,
    this.style,
    this.color,
    this.buttonHeight = 49,
    super.key,
  });

  final String buttonText;
  final bool enable;
  final VoidCallback? onPress;
  final EdgeInsets margin;
  final TextStyle? style;
  final Color? color;
  final double buttonHeight;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: margin,
      child: Material(
        color: enable
            ? color ?? colorScheme.primary
            : color?.withValues(alpha: 0.4) ??
                  colorScheme.primary.withValues(alpha: 0.4),
        borderRadius: AppRadius.lgAll,
        child: InkWell(
          onTap: enable ? onPress : null,
          child: SizedBox(
            height: buttonHeight,
            width: double.infinity,
            child: Center(
              child: Text(
                buttonText,
                style:
                    style ??
                    textTheme.titleLarge!.copyWith(
                      color: enable
                          ? colorScheme.onPrimary
                          : colorScheme.onPrimary.withValues(alpha: 0.5),
                      fontSize: 18,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
