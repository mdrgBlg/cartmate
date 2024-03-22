import 'package:flutter/material.dart';

import '../../../../constants/custom_colors.dart';

class CustomProgressIndicator extends StatelessWidget {
  final int screenIndex;
  const CustomProgressIndicator({
    super.key,
    required this.screenIndex,
  });

  final int screenCount = 3;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        screenCount,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          height: 4,
          width: 24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(99),
            color: index == screenIndex ? CustomColors.primary : CustomColors.customGrey,
          ),
        ),
      ),
    );
  }
}
