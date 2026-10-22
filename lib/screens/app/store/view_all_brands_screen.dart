import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '/utils/constants/custom_colors.dart';
import '/models/brand_model.dart';
import '/widgets/custom_app_bar.dart';
import '/widgets/layouts/main_layout.dart';
import 'widgets/brand_grid.dart';

class ViewAllBrandsScreen extends StatelessWidget {
  const ViewAllBrandsScreen({required this.brandsList, super.key});
  final List<BrandModel> brandsList;

  static const routeName = '/brands';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MainLayout(
      backgroundColor: CustomColors.secondary,
      appBar: const CustomAppBar(titleText: "Brand", type: AppBarType.dark),
      child: Column(
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
              ? BrandGrid(brandList: brandsList, showLimited: false)
              : Container(),
        ],
      ),
    );
  }
}
