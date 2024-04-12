import 'package:e_commerce/screens/app/home/home_models/products_model.dart';
import 'package:flutter/material.dart';

import '../screens/app/home/home_widgets/custom_product_card.dart';

class ProductsGridView extends StatelessWidget {
  final List<ProductsModel> productsList;
  const ProductsGridView({
    super.key,
    required this.productsList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          mainAxisExtent: 263,
        ),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: productsList.length,
        itemBuilder: (context, index) => productsList.isNotEmpty
            ? CustomProductCard(
                productsModel: productsList[index],
              )
            : null,
      ),
    );
  }
}
