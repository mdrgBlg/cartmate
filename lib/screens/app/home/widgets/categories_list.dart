import 'package:flutter/material.dart';

import '/models/categories_model.dart';

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
    return Padding(
      padding: const EdgeInsets.only(left: 14),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              height: 48,
              width: 48,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(99),
                color: Colors.white,
              ),
              child: Image.asset(categoriesModel.iconName),
            ),
            Flexible(
              child: Container(
                width: 56,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  categoriesModel.categoryName,
                  style: textTheme.bodySmall!.copyWith(
                    color: Colors.white,
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
