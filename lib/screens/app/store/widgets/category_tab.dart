import 'package:flutter/material.dart';

import '/utils/constants/custom_colors.dart';

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
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 4,
                color: isActive ? CustomColors.primary : Colors.transparent,
              ),
            ),
          ),
          child: Text(
            categoryName,
            style: textTheme.bodyLarge!.copyWith(
              color: isActive
                  ? CustomColors.primary
                  : CustomColors.text.withValues(alpha: 0.4),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
