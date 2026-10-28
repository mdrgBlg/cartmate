import 'package:flutter/material.dart';

import '/core/widgets/custom_app_bar.dart';
import '/core/widgets/layouts/main_layout.dart';
import '/core/widgets/products_grid_view/products_grid_view.dart';
import '/data/models/products_model.dart';
import '/utils/common_utils.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    required this.categoryName,
    required this.productsList,
    super.key,
  });
  final String categoryName;
  final List<ProductsModel> productsList;

  static const routeName = '/categories';

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBar: CustomAppBar(titleText: categoryName, type: AppBarType.dark),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  fetchImage(categoryName),
                  fit: BoxFit.fill,
                  height: 200,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: ProductsGridView(productsList: productsList),
            ),
          ],
        ),
      ),
    );
  }
}
