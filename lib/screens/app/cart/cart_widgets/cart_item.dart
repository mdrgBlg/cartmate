import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '/providers/main_provider.dart';
import '../../home/home_models/products_model.dart';
import '/constants/custom_colors.dart';
import '/constants/custom_images.dart';

class CartItem extends StatelessWidget {
  final ProductsModel product;
  const CartItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mainProvider = Provider.of<MainProvider>(
      context,
      listen: false,
    );
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Container(
        width: double.infinity,
        height: 112,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: CustomColors.grayDark.withOpacity(0.2),
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
                    child: Image.asset(
                      CustomImages.shoesGrid,
                      height: 64,
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
                            product.brandModel?.brandName ?? "",
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
                        product.productName,
                        style: textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                const Gap(72),
                InkWell(
                  onTap: () => mainProvider.removeProductFromCart(product),
                  child: Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(99),
                      color: Colors.black.withOpacity(0.4),
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
                Consumer<MainProvider>(
                  builder: (context, value, child) => Text(
                    product.count.toString(),
                    style: textTheme.bodyLarge,
                  ),
                ),
                const Gap(12),
                InkWell(
                  onTap: () => mainProvider.addProductToCart(product),
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
                  "${(product.price - product.price * (product.discount / 100)) * product.count} ${product.currency}",
                  style: textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
