import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '/constants/custom_colors.dart';
import '/models/cart_model.dart';
import '/providers/main_provider.dart';

class CartItem extends StatelessWidget {
  final CartModel cartModel;
  final bool isCartItem;
  final double height;
  const CartItem({
    super.key,
    required this.cartModel,
    this.isCartItem = true,
    this.height = 112,
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
        height: height,
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
                    child: CachedNetworkImage(
                      imageUrl:
                          cartModel.productModel?.productImageList.first ?? "",
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
                            cartModel.productModel?.brandModel?.brandName ?? "",
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
                        cartModel.productModel?.productName ?? "",
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
                                const TextSpan(
                                  text: "Size: ",
                                ),
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
                        const SizedBox(
                          width: 8,
                        ),
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
                                  const TextSpan(
                                    text: "Quantity: ",
                                  ),
                                  TextSpan(
                                    text: cartModel.productModel?.count
                                        .toString(),
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
            if (isCartItem)
              Row(
                children: [
                  const Gap(72),
                  InkWell(
                    onTap: () => mainProvider.removeProductFromCart(cartModel),
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
                    builder: (_, value, child) => Text(
                      cartModel.productModel?.count.toString() ?? "",
                      style: textTheme.bodyLarge,
                    ),
                  ),
                  const Gap(12),
                  InkWell(
                    onTap: () => mainProvider.increaseProductInCart(cartModel),
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
                    cartModel.productModel != null
                        ? "${(cartModel.productModel!.price - cartModel.productModel!.price * (cartModel.productModel!.discount / 100)) * cartModel.productModel!.count} ${cartModel.productModel!.currency}"
                        : "",
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
