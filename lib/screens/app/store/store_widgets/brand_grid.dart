import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/main_provider.dart';
import '/constants/custom_colors.dart';
import '/widgets/app_network_image.dart';
import '/helpers/custom_navigator.dart';
import '/helpers/helpers.dart';
import '/models/brand_model.dart';
import 'brand_products.dart';

class BrandGrid extends StatelessWidget {
  final List<BrandModel> brandList;

  final bool showLimited;
  const BrandGrid({
    super.key,
    required this.brandList,
    required this.showLimited,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mainProvider = Provider.of<MainProvider>(
      context,
      listen: false,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          mainAxisExtent: 60,
        ),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: showLimited
            ? brandList.length > 6
                ? 6
                : brandList.length
            : brandList.length,
        itemBuilder: (context, index) => brandList.isNotEmpty
            ? InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => CustomNavigator.pushNavigation(
                  context: context,
                  routeName: BrandProducts.routeName,
                  screen: BrandProducts(
                    productsList: Helpers.getBrandProducts(
                        mainProvider.productsList, brandList[index]),
                    brandModel: brandList[index],
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 12,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: CustomColors.text.withOpacity(0.4),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 36,
                        width: 36,
                        child: AppNetworkImage(
                          imageUrl: brandList[index].iconName,
                          errorIcon: Icons.store,
                          errorIconSize: 20,
                        ),
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
                                Expanded(
                                  child: Text(
                                    brandList[index].brandName,
                                    style: textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.blueAccent,
                                  size: 14,
                                ),
                                SizedBox(
                                  width: 12,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  brandList[index].productCount.toString(),
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
                ),
              )
            : null,
      ),
    );
  }
}
