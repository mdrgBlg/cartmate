import 'package:flutter/material.dart';

import '/core/styles/app_spacing.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({
    required this.categoryName,
    required this.onTap,
    required this.isActive,
    super.key,
  });

  final String categoryName;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.screenHorizontal),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 4,
                color: isActive ? colorScheme.primary : Colors.transparent,
              ),
            ),
          ),
          child: Text(
            categoryName,
            style: textTheme.bodyLarge!.copyWith(
              color: isActive
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
