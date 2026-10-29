import 'package:flutter/material.dart';

import '/core/l10n/app_localizations.dart';
import '/core/styles/app_radius.dart';
import '/core/styles/app_spacing.dart';
import '/core/widgets/app_network_image.dart';
import '/data/models/brand_model.dart';

class BrandTile extends StatelessWidget {
  const BrandTile({
    required this.brand,
    this.onTap,
    this.padding = const EdgeInsets.only(left: AppSpacing.md),
    super.key,
  });

  final BrandModel brand;
  final VoidCallback? onTap;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final localization = AppLocalizations.of(context);
    final countStyle = textTheme.bodySmall!.copyWith(
      color: colorScheme.onSurfaceVariant,
    );

    return InkWell(
      borderRadius: AppRadius.lgAll,
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: AppRadius.lgAll,
          border: Border.all(color: colorScheme.outlineVariant),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 36,
              width: 36,
              child: AppNetworkImage(
                imageUrl: brand.iconName,
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
                      Flexible(
                        child: Text(
                          brand.brandName,
                          style: textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
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
                  Row(
                    children: [
                      Text(brand.productCount.toString(), style: countStyle),
                      const SizedBox(width: 2),
                      Flexible(
                        child: Text(
                          localization.storeProductsLabel(brand.productCount),
                          style: countStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
