import 'package:flutter/material.dart';

import '/core/styles/custom_colors.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({
    required this.screenIndex,
    required this.progressLength,
    super.key,
  });
  final int screenIndex;

  final int progressLength;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        progressLength,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          height: 4,
          width: 24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(99),
            color: index == screenIndex
                ? CustomColors.primary
                : CustomColors.customGrey,
          ),
        ),
      ),
    );
  }
}
