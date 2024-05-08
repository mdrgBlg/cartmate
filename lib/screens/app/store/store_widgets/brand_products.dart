import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../home/home_models/products_model.dart';
import '/constants/custom_colors.dart';
import '/widgets/products_grid_view.dart';
import 'brand_container.dart';

class BrandProducts extends StatelessWidget {
  final List<ProductsModel> productsList;
  final String brandName;
  final int productCount;
  const BrandProducts({
    super.key,
    required this.productsList,
    required this.brandName,
    required this.productCount,
  });

  static const routeName = '/brandProducts';

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
            brandName,
            style: textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
              child: BrandContainer(
                brandName: brandName,
                productCount: productCount.toString(),
              ),
            ),
            const Gap(12),
            ProductsGridView(
              productsList: productsList,
            ),
          ],
        ),
      ),
    );
  }
}
