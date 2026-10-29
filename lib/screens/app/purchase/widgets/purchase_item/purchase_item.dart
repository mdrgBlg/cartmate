import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '/core/l10n/app_localizations.dart';
import '/core/styles/app_radius.dart';
import '/core/styles/app_shadows.dart';
import '/core/styles/app_spacing.dart';
import '/core/widgets/app_network_image.dart';
import '/data/models/cart_model.dart';
import '/utils/extensions/price_extension.dart';
import 'providers/purchase_item_provider.dart';

class PurchaseItem extends StatelessWidget {
  const PurchaseItem({
    required this.cartModel,
    this.isCartItem = true,
    this.height = 112,
    super.key,
  });

  final CartModel cartModel;
  final bool isCartItem;
  final double height;

  @override
  Widget build(BuildContext context) {
    // The key recreates the provider when the list reuses this element for a
    // different cart entry.
    return ChangeNotifierProvider(
      key: ValueKey(cartModel.id),
      create: (context) => PurchaseItemProvider(
        cartRepository: context.read(),
        cartModel: cartModel,
      ),
      child: _PurchaseItemView(
        cartModel: cartModel,
        isCartItem: isCartItem,
        height: height,
      ),
    );
  }
}

class _PurchaseItemView extends StatelessWidget {
  const _PurchaseItemView({
    required this.cartModel,
    required this.isCartItem,
    required this.height,
  });

  final CartModel cartModel;
  final bool isCartItem;
  final double height;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final localization = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        AppSpacing.md,
        AppSpacing.screenHorizontal,
        0,
      ),
      child: Container(
        width: double.infinity,
        height: height,
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: AppRadius.lgAll,
          boxShadow: AppShadows.cardFor(colorScheme),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: AppRadius.lgAll,
                  ),
                  child: ClipRRect(
                    borderRadius: AppRadius.lgAll,
                    child: AppNetworkImage(
                      imageUrl:
                          cartModel.productModel.productImageList.firstOrNull ??
                          '',
                      height: 64,
                      width: 64,
                    ),
                  ),
                ),
                const Gap(12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(4),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Text(
                            cartModel.productModel.brandModel?.brandName ?? "",
                            style: textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.check_circle,
                          color: colorScheme.primary,
                          size: 12,
                        ),
                      ],
                    ),
                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        cartModel.productModel.productName,
                        style: textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Row(
                      spacing: 8,
                      children: [
                        if (cartModel.size.isNotEmpty)
                          Container(
                            alignment: AlignmentDirectional.centerStart,
                            child: RichText(
                              text: TextSpan(
                                style: textTheme.bodySmall!.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(text: localization.purchaseItemSize),
                                  TextSpan(
                                    text: cartModel.size,
                                    style: textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (!isCartItem)
                          Container(
                            alignment: AlignmentDirectional.centerStart,
                            child: RichText(
                              text: TextSpan(
                                style: textTheme.bodySmall!.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: localization.purchaseItemQuantity,
                                  ),
                                  TextSpan(
                                    text: cartModel.quantity.toString(),
                                    style: textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            if (isCartItem) const _CartQuantityAndPrice(),
          ],
        ),
      ),
    );
  }
}

class _CartQuantityAndPrice extends StatelessWidget {
  const _CartQuantityAndPrice();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Consumer<PurchaseItemProvider>(
      builder: (context, provider, child) {
        final cartModel = provider.cartModel;
        return Row(
          children: [
            const Gap(72),
            InkWell(
              onTap: provider.decreaseQuantity,
              child: Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  borderRadius: AppRadius.pillAll,
                  color: colorScheme.inverseSurface.withValues(alpha: 0.4),
                ),
                alignment: AlignmentDirectional.center,
                child: Text(
                  "-",
                  style: textTheme.bodyLarge!.copyWith(
                    fontSize: 20,
                    height: 1.1,
                    color: colorScheme.onInverseSurface,
                  ),
                ),
              ),
            ),
            const Gap(12),
            Text(cartModel.quantity.toString(), style: textTheme.bodyLarge),
            const Gap(12),
            InkWell(
              onTap: provider.increaseQuantity,
              child: Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  borderRadius: AppRadius.pillAll,
                  color: colorScheme.primary,
                ),
                alignment: AlignmentDirectional.center,
                child: Text(
                  "+",
                  style: textTheme.bodyLarge!.copyWith(
                    fontSize: 20,
                    height: 1.1,
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Text(
              cartModel.getTotalPrice.formatPrice(
                cartModel.currency,
                locale: Localizations.localeOf(context).toString(),
              ),
              style: textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        );
      },
    );
  }
}
