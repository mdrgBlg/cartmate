import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '/core/styles/app_radius.dart';
import '/core/styles/app_spacing.dart';
import '/core/widgets/app_network_image.dart';
import '/data/models/brand_model.dart';
import '/data/models/products_model.dart';

class CategoriesBrands extends StatelessWidget {
  const CategoriesBrands({
    required this.categoryBrand,
    required this.productsList,
    required this.onTap,
    super.key,
  });
  final BrandModel categoryBrand;
  final List<ProductsModel> productsList;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.lgAll,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: AppRadius.lgAll,
          border: Border.all(color: colorScheme.outlineVariant, width: 1.5),
        ),
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Gap(8),
                SizedBox(
                  height: 36,
                  width: 36,
                  child: AppNetworkImage(
                    imageUrl: categoryBrand.iconName,
                    errorIcon: Icons.store,
                    errorIconSize: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            categoryBrand.brandName,
                            style: textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.check_circle,
                            color: colorScheme.primary,
                            size: 14,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(16),
            Row(
              children: [
                if (productsList.length >= 3) const Spacer(),
                ...List.generate(
                  productsList.length > 3 ? 3 : productsList.length,
                  (index) => Container(
                    height: 80,
                    width: 80,
                    margin: EdgeInsets.only(
                      left: index == 0 ? 0 : AppSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: AppRadius.lgAll,
                      border: Border.all(color: colorScheme.outlineVariant),
                    ),
                    child: ClipRRect(
                      borderRadius: AppRadius.lgAll,
                      child: AppNetworkImage(
                        imageUrl:
                            productsList[index].productImageList.firstOrNull ??
                            '',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
