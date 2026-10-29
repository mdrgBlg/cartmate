import 'package:flutter/material.dart';

import '/core/styles/app_radius.dart';
import '/core/styles/app_spacing.dart';
import '/data/models/categories_model.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    required this.categoriesModel,
    required this.onTap,
    super.key,
  });

  final CategoriesModel categoriesModel;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(left: 14),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              height: 48,
              width: 48,
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                borderRadius: AppRadius.pillAll,
                color: colorScheme.surface,
              ),
              child: Image.asset(
                categoriesModel.iconName,
                color: colorScheme.onSurface,
              ),
            ),
            Flexible(
              child: Container(
                width: 56,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: AppSpacing.xs),
                child: Text(
                  categoriesModel.categoryName,
                  style: textTheme.bodySmall!.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
