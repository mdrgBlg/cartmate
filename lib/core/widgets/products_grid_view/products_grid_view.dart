import 'package:flutter/material.dart';

import '/data/models/products_model.dart';
import '../../styles/app_spacing.dart';
import 'widgets/custom_product_card.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({required this.productsList, super.key});

  final List<ProductsModel> productsList;

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
          crossAxisSpacing: AppSpacing.sm,
          mainAxisSpacing: AppSpacing.sm,
          mainAxisExtent: 263,
        ),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: productsList.length,
        itemBuilder: (context, index) => productsList.isNotEmpty
            ? CustomProductCard(
                productsModel: productsList[index],
                productsList: productsList,
              )
            : null,
      ),
    );
  }
}
