import 'package:e_commerce/models/brand_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../store_providers/store_provider.dart';
import '/constants/custom_colors.dart';
import '/widgets/products_grid_view.dart';
import 'brand_container.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({required this.brandModel, this.categoryId, super.key});

  final BrandModel brandModel;
  final String? categoryId;

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
            brandModel.brandName,
            style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
              child: BrandContainer(brand: brandModel),
            ),
            const Gap(12),
            Consumer<StoreProvider>(
              builder: (_, storeProvider, __) => ProductsGridView(
                productsList: storeProvider.getBrandProducts(
                  brandModel,
                  categoryId: categoryId,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
