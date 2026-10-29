import 'package:flutter/material.dart';

import '/core/styles/app_spacing.dart';

class InformationWidget extends StatelessWidget {
  const InformationWidget({
    required this.sectionTitle,
    required this.sectionText,
    this.onTap,
    super.key,
  });

  final String sectionTitle;
  final String sectionText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: AppSpacing.screenPadding,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                sectionTitle,
                style: textTheme.bodyMedium!.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                sectionText,
                style: textTheme.bodyMedium!.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (onTap != null)
              Icon(
                Icons.arrow_forward_ios,
                color: colorScheme.onSurfaceVariant,
                size: 16,
              ),
          ],
        ),
      ),
    );
  }
}
