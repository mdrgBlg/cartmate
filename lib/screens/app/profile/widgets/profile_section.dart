import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '/core/styles/app_spacing.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({
    required this.title,
    required this.children,
    super.key,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppSpacing.screenHorizontal),
          child: Text(
            title,
            style: textTheme.titleLarge!.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        const Gap(16),
        for (int i = 0; i < children.length; i++) ...[
          if (i > 0) const Gap(12),
          children[i],
        ],
        const Gap(16),
        const Padding(padding: AppSpacing.screenPadding, child: Divider()),
      ],
    );
  }
}
