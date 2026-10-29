import 'package:flutter/material.dart';

import '/core/styles/app_radius.dart';
import '/core/styles/app_spacing.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        progressLength,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          height: 4,
          width: 24,
          decoration: BoxDecoration(
            borderRadius: AppRadius.pillAll,
            color: index == screenIndex
                ? colorScheme.primary
                : colorScheme.outline,
          ),
        ),
      ),
    );
  }
}
