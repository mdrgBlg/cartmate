import 'package:flutter/material.dart';

import '/core/styles/app_spacing.dart';
import '/data/models/brand_model.dart';
import '/utils/custom_navigator.dart';
import '../brand_products_screen.dart';
import 'brand_tile.dart';

class BrandGrid extends StatelessWidget {
  const BrandGrid({
    required this.brandList,
    required this.showLimited,
    super.key,
  });
  final List<BrandModel> brandList;
  final bool showLimited;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
        vertical: 6,
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppSpacing.md,
          mainAxisSpacing: AppSpacing.md,
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
            ? BrandTile(
                brand: brandList[index],
                onTap: () => CustomNavigator(context).pushNavigation(
                  routeName: BrandProductsScreen.routeName,
                  screen: BrandProductsScreen(brandModel: brandList[index]),
                ),
              )
            : null,
      ),
    );
  }
}
