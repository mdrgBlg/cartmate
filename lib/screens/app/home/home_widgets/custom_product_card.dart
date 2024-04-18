import 'package:e_commerce/helpers/custom_navigator.dart';
import 'package:e_commerce/providers/main_provider.dart';
import 'package:e_commerce/providers/product_details_provider.dart';
import 'package:e_commerce/screens/app/home/home_models/products_model.dart';
import 'package:e_commerce/screens/app/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/constants/custom_colors.dart';
import '/constants/custom_images.dart';

class CustomProductCard extends StatelessWidget {
  final ProductsModel productsModel;
  final List<ProductsModel> productsList;
  const CustomProductCard({
    super.key,
    required this.productsModel,
    required this.productsList,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final mainProvider = Provider.of<MainProvider>(
      context,
      listen: false,
    );
    return InkWell(
      onTap: () => CustomNavigator.pushNavigation(
        context: context,
        routeName: ProductDetailsScreen.routeName,
        screen: ChangeNotifierProvider(
          create: (_) => ProductDetailsProvider(),
          child: ProductDetailsScreen(
            product: productsList.singleWhere(
              (element) => element.id == productsModel.id,
            ),
          ),
        ),
      ),
      child: Container(
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
                    child: Image.asset(
                      CustomImages.shoesGrid,
                      height: 140,
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
                        style: textTheme.bodySmall!.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const Icon(
                        Icons.check_circle,
                        color: Colors.blueAccent,
                        size: 14,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            "${(productsModel.price - productsModel.price * (productsModel.discount / 100))} ${productsModel.currency}",
                            style: textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                        padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                        child: Text(
                          "+",
                          style: textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                )
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
              child: InkWell(
                onTap: () async {
                  mainProvider.wishlistFlagChange(productsModel);
                  if (productsModel.whishlist) {
                    await mainProvider.addProductToWhishlist(productsModel);
                  } else {
                    await mainProvider.removeProductFromWhishlist(productsModel);
                  }
                },
                borderRadius: BorderRadius.circular(99),
                child: Consumer<MainProvider>(
                  builder: (context, value, child) => Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(99),
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: productsModel.whishlist ? Colors.red : Colors.grey,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
