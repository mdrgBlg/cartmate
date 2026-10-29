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

    return Padding(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(8),
          Text(
            title,
            style: textTheme.titleLarge!.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const Gap(8),
          for (int i = 0; i < children.length; i++) ...[children[i]],
          const Gap(8),
          const Divider(),
        ],
      ),
    );
  }
}
