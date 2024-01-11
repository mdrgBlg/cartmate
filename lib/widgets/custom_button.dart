import 'package:flutter/material.dart';

import '../constants/custom_colors.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final bool enable;
  final VoidCallback? onPress;
  const CustomButton({
    super.key,
    required this.buttonText,
    required this.enable,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
          color: enable
              ? CustomColors.primary
              : CustomColors.disabled.withOpacity(
                  0.4,
                ),
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
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: enable ? Colors.white : Colors.white.withOpacity(0.5),
                ),
              )),
            )),
          )),
    );
  }
}
