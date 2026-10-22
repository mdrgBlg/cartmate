import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '/constants/custom_colors.dart';
import '/models/cart_model.dart';
import 'providers/purchase_item_provider.dart';
import '/widgets/app_network_image.dart';

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
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Container(
        width: double.infinity,
        height: height,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: CustomColors.grayDark.withValues(alpha: 0.2),
              blurRadius: 50,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: AppNetworkImage(
                      imageUrl: cartModel.productModel.productImageList.first,
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
                              color: CustomColors.grayDark,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.check_circle,
                          color: Colors.blueAccent,
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
                      children: [
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          child: RichText(
                            text: TextSpan(
                              style: textTheme.bodySmall!.copyWith(
                                color: CustomColors.grayDark,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                const TextSpan(text: "Size: "),
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
                        const SizedBox(width: 8),
                        if (!isCartItem)
                          Container(
                            alignment: AlignmentDirectional.centerStart,
                            child: RichText(
                              text: TextSpan(
                                style: textTheme.bodySmall!.copyWith(
                                  color: CustomColors.grayDark,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  const TextSpan(text: "Quantity: "),
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
                  borderRadius: BorderRadius.circular(99),
                  color: Colors.black.withValues(alpha: 0.4),
                ),
                alignment: AlignmentDirectional.center,
                child: Text(
                  "-",
                  style: textTheme.bodyLarge!.copyWith(
                    fontSize: 20,
                    height: 1.1,
                    color: Colors.white,
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
                  borderRadius: BorderRadius.circular(99),
                  color: CustomColors.primary,
                ),
                alignment: AlignmentDirectional.center,
                child: Text(
                  "+",
                  style: textTheme.bodyLarge!.copyWith(
                    fontSize: 20,
                    height: 1.1,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Text(
              cartModel.getTotalPriceWithCurrency,
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
