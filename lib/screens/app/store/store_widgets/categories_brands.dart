import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../home/home_models/products_model.dart';
import '/constants/custom_colors.dart';
import '/constants/custom_images.dart';
import '/helpers/custom_navigator.dart';
import '/models/brand_model.dart';
import 'brand_products.dart';

class CategoriesBrands extends StatefulWidget {
  final BrandModel categoryBrand;
  final List<ProductsModel> brandProducts;
  const CategoriesBrands({
    super.key,
    required this.categoryBrand,
    required this.brandProducts,
  });

  @override
  State<CategoriesBrands> createState() => _CategoriesBrandsState();
}

class _CategoriesBrandsState extends State<CategoriesBrands> {
  List<ProductsModel> productsList = [];
  @override
  void initState() {
    for (var e in widget.brandProducts) {
      if (widget.categoryBrand.id == e.brandModel?.id) {
        productsList.add(e);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () => CustomNavigator.pushNavigation(
        context: context,
        routeName: BrandProducts.routeName,
        screen: BrandProducts(
          productsList: productsList,
          brandName: widget.categoryBrand.brandName,
          productCount: widget.categoryBrand.productCount,
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
                  child: Image.asset(CustomImages.nikeLogo),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.categoryBrand.brandName,
                            style: textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Icon(
                            Icons.check_circle,
                            color: Colors.blueAccent,
                            size: 14,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            widget.categoryBrand.productCount.toString(),
                            style: textTheme.bodySmall!.copyWith(
                              color: CustomColors.text.withOpacity(0.4),
                            ),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            "products",
                            style: textTheme.bodySmall!.copyWith(
                              color: CustomColors.text.withOpacity(0.4),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
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
                    margin: EdgeInsets.only(left: index == 0 ? 0 : 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        productsList[0].productImageList.first,
                        fit: BoxFit.fill,
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
