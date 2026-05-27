import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../home/home_models/products_model.dart';
import '/constants/custom_colors.dart';
import '/widgets/app_network_image.dart';
import '/helpers/custom_navigator.dart';
import '/models/brand_model.dart';
import 'brand_products.dart';

class CategoriesBrands extends StatelessWidget {
  final BrandModel categoryBrand;
  final List<ProductsModel> brandProducts;
  final List<ProductsModel> productsList;
  const CategoriesBrands({
    super.key,
    required this.categoryBrand,
    required this.brandProducts,
    required this.productsList,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () => CustomNavigator.pushNavigation(
        context: context,
        routeName: BrandProducts.routeName,
        screen: BrandProducts(
          productsList: productsList,
          brandModel: categoryBrand,
        ),
      ),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: CustomColors.text.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                          const Icon(
                            Icons.check_circle,
                            color: Colors.blueAccent,
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
                    margin: EdgeInsets.only(left: index == 0 ? 0 : 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.black.withOpacity(0.1)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: AppNetworkImage(
                        imageUrl: productsList[index].productImageList.first,
                        fit: BoxFit.fill,
                        errorIconSize: 32,
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
