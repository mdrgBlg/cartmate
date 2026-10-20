import 'package:flutter/material.dart';

import '/constants/custom_colors.dart';
import '/models/categories_model.dart';

class CategoriesTextWidget extends StatelessWidget {
  const CategoriesTextWidget({
    required this.categoriesModel,
    required this.onTap,
    required this.isActive,
    super.key,
  });

  final CategoriesModel categoriesModel;
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
            categoriesModel.categoryName,
            style: textTheme.bodyLarge!.copyWith(
              color: isActive
                  ? CustomColors.primary
                  : CustomColors.text.withOpacity(0.4),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
