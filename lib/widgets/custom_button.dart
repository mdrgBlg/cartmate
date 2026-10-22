import 'package:flutter/material.dart';

import '../constants/custom_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.buttonText,
    required this.enable,
    this.onPress,
    this.margin = const EdgeInsets.symmetric(horizontal: 20),
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
    return Container(
      margin: margin,
      child: Material(
        color: enable
            ? CustomColors.primary
            : CustomColors.disabled.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16),
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
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.5),
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
