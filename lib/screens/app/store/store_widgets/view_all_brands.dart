import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '/constants/custom_colors.dart';
import '/models/brand_model.dart';
import 'brand_grid.dart';

class ViewAllBrands extends StatelessWidget {
  final List<BrandModel> brandsList;
  const ViewAllBrands({
    super.key,
    required this.brandsList,
  });

  static const routeName = '/brands';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.secondary,
        appBar: AppBar(
          backgroundColor: CustomColors.secondary,
          elevation: 0,
          foregroundColor: Colors.black,
          titleSpacing: 4,
          title: Text(
            "Brand",
            style: textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(16),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 8),
              child: Text(
                "Brands",
                style: textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            brandsList.isNotEmpty
                ? BrandGrid(
                    brandList: brandsList,
                    showLimited: false,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
