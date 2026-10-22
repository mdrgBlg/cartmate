import 'package:flutter/material.dart';

import '/models/products_model.dart';
import '/screens/app/product_details/product_details_screen.dart';
import '/utils/constants/custom_colors.dart';
import '/utils/custom_navigator.dart';
import '/widgets/app_network_image.dart';
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

    return InkWell(
      onTap: () => CustomNavigator(context).pushNavigation(
        routeName: ProductDetailsScreen.routeName,
        screen: ProductDetailsScreen(productsModel: productsModel),
      ),
      child: Container(
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
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: AppNetworkImage(
                      imageUrl: productsModel.productImageList.first,
                      height: 140,
                      errorIconSize: 64,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                  child: Text(
                    productsModel.productName,
                    style: textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
                  child: Row(
                    children: [
                      Text(
                        productsModel.brandModel?.brandName ?? "",
                        style: textTheme.bodySmall!.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.check_circle,
                        color: Colors.blueAccent,
                        size: 14,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 0, 0),
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
                                productsModel.price.toDouble().toString(),
                                style: textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: CustomColors.customGrey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            Text(
                              productsModel.getPriceWithDiscountAndCurrency,
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
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
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
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "${productsModel.discount}%",
                  style: textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
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
