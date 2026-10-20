import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '/constants/custom_colors.dart';
import '/models/brand_model.dart';
import '/utils/custom_navigator.dart';
import '/widgets/app_network_image.dart';
import '../../../../models/products_model.dart';
import '../store_providers/store_provider.dart';
import 'brand_products.dart';

class CategoriesBrands extends StatelessWidget {
  const CategoriesBrands({
    required this.categoryBrand,
    required this.brandProducts,
    required this.productsList,
    super.key,
  });
  final BrandModel categoryBrand;
  final List<ProductsModel> brandProducts;
  final List<ProductsModel> productsList;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () => CustomNavigator(context).pushNavigation(
        routeName: BrandProducts.routeName,
        screen: ChangeNotifierProvider.value(
          value: context.read<StoreProvider>(),
          child: BrandProducts(
            brandModel: categoryBrand,
            categoryId: context.read<StoreProvider>().selectedCategory?.id,
          ),
        ),
      ),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: CustomColors.text.withValues(alpha: 0.5),
            width: 1.5,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                      border: Border.all(
                        color: Colors.black.withValues(alpha: 0.1),
                      ),
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
