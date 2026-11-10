import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '/core/l10n/app_localizations.dart';
import '/core/styles/app_spacing.dart';
import '/core/widgets/custom_button.dart';
import '/utils/extensions/price_extension.dart';
import '/utils/snack_bar_popup.dart';
import '../providers/product_details_provider.dart';

class ProductPurchaseBar extends StatelessWidget {
  const ProductPurchaseBar({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final locale = Localizations.localeOf(context).toString();

    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(top: BorderSide(color: colorScheme.outlineVariant)),
      ),
      child: SafeArea(
        top: false,
        child: Consumer<ProductDetailsProvider>(
          builder: (context, provider, _) {
            final product = provider.product;
            return Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (product.discount > 0)
                      Text(
                        product.price.formatPrice(
                          product.currency,
                          locale: locale,
                        ),
                        style: textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.outline,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Text(
                      product.getPriceWithDiscount.formatPrice(
                        product.currency,
                        locale: locale,
                      ),
                      style: textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Gap(AppSpacing.lg),
                Expanded(
                  child: CustomButton(
                    buttonText: localization.productAddToCart,
                    enable: provider.canAddToCart,
                    margin: EdgeInsets.zero,
                    onPress: () {
                      provider.addToCart();
                      SnackBarPopup.showMessage(
                        context,
                        message: localization.productAddedToCart,
                        snackBarMessageType: SnackBarMessageType.success,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
