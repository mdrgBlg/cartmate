import 'package:flutter/material.dart';

import '/utils/helpers.dart';
import '/widgets/products_grid_view.dart';
import 'home/home_models/products_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    required this.productsList,
    required this.categoryName,
    super.key,
  });
  final List<ProductsModel> productsList;
  final String categoryName;

  static const routeName = '/categories';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
          title: Text(
            categoryName,
            style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.white,
        body: SizedBox(
          width: double.infinity,
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
                      Helpers.fetchImage(categoryName),
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
        ),
      ),
    );
  }
}
