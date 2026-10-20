import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '/constants/custom_colors.dart';
import '/models/brand_model.dart';
import '/widgets/custom_app_bar.dart';
import '/widgets/main_layout.dart';
import '/widgets/products_grid_view.dart';
import '../store_providers/store_provider.dart';
import 'brand_container.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({required this.brandModel, this.categoryId, super.key});

  final BrandModel brandModel;
  final String? categoryId;

  static const routeName = '/brandProducts';

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      backgroundColor: CustomColors.secondary,
      appBar: CustomAppBar(
        titleText: brandModel.brandName,
        type: AppBarType.dark,
      ),
      child: Column(
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
    );
  }
}
