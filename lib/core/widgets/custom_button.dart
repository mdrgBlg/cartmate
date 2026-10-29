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
    super.key,
  });

  final String buttonText;
  final bool enable;
  final VoidCallback? onPress;
  final EdgeInsets margin;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: margin,
      child: Material(
        color: enable
            ? colorScheme.primary
            : colorScheme.primary.withValues(alpha: 0.4),
        borderRadius: AppRadius.lgAll,
        child: InkWell(
          onTap: enable ? onPress : null,
          child: Center(
            child: SizedBox(
              height: 49,
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
      ),
    );
  }
}
