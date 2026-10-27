import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '/core/styles/custom_colors.dart';

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            title,
            style: textTheme.titleLarge!.copyWith(
              color: Colors.black,
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
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(color: CustomColors.grayDark),
        ),
      ],
    );
  }
}
