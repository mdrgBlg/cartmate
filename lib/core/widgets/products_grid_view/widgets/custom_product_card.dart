import 'package:flutter/material.dart';

import '/data/models/products_model.dart';
import '/screens/app/product_details/product_details_screen.dart';
import '/utils/custom_navigator.dart';
import '/utils/extensions/price_extension.dart';
import '../../../styles/app_radius.dart';
import '../../../styles/app_shadows.dart';
import '../../../styles/app_spacing.dart';
import '../../app_network_image.dart';
import '../../wishlist_heart_button/wishlist_heart_button.dart';
import 'product_cart_quantity/product_cart_quantity.dart';

class CustomProductCard extends StatelessWidget {
  const CustomProductCard({
    required this.productsModel,
    required this.productsList,
    super.key,
  });
  final ProductsModel productsModel;
  final List<ProductsModel> productsList;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final locale = Localizations.localeOf(context).toString();

    return InkWell(
      onTap: () => CustomNavigator(context).pushNavigation(
        routeName: ProductDetailsScreen.routeName,
        screen: ProductDetailsScreen(productsModel: productsModel),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: AppRadius.lgAll,
          boxShadow: AppShadows.card,
        ),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (productsModel.productImageList.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: const BoxDecoration(
                      borderRadius: AppRadius.lgAll,
                    ),
                    child: ClipRRect(
                      borderRadius: AppRadius.lgAll,
                      child: AppNetworkImage(
                        imageUrl:
                            productsModel.productImageList.firstOrNull ?? '',
                        height: 140,
                        errorIconSize: 64,
                      ),
                    ),
                  ),
                Container(
                  margin: const EdgeInsets.fromLTRB(
                    AppSpacing.sm,
                    AppSpacing.sm,
                    0,
                    AppSpacing.sm,
                  ),
                  child: Text(
                    productsModel.productName,
                    style: textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.sm,
                    0,
                    AppSpacing.sm,
                    AppSpacing.md,
                  ),
                  child: Row(
                    children: [
                      Text(
                        productsModel.brandModel?.brandName ?? "",
                        style: textTheme.bodySmall!.copyWith(
                          color: colorScheme.onSurfaceVariant,
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
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.sm,
                    AppSpacing.xs,
                    0,
                    0,
                  ),
                  child: SizedBox(
                    height: 42,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (productsModel.discount > 0)
                              Text(
                                productsModel.price.formatPrice(
                                  productsModel.currency,
                                  locale: locale,
                                ),
                                style: textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.outline,
                                  decoration: TextDecoration.lineThrough,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            Text(
                              productsModel.getPriceWithDiscount.formatPrice(
                                productsModel.currency,
                                locale: locale,
                              ),
                              style: textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Container(
                          height: 32,
                          width: 36,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: colorScheme.inverseSurface,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(AppRadius.lg),
                              bottomRight: Radius.circular(AppRadius.lg),
                            ),
                          ),
                          child: ProductCartQuantity(
                            productId: productsModel.id,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 8,
              top: 8,
              child: Container(
                alignment: AlignmentDirectional.center,
                width: 36,
                height: 20,
                decoration: BoxDecoration(
                  color: colorScheme.secondary,
                  borderRadius: AppRadius.xsAll,
                ),
                child: Text(
                  "${productsModel.discount}%",
                  style: textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: colorScheme.onSecondary,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 4,
              top: 4,
              child: WishlistHeartButton(product: productsModel),
            ),
          ],
        ),
      ),
    );
  }
}
