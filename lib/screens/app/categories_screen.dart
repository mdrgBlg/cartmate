import 'package:e_commerce/widgets/products_grid_view.dart';
import 'package:flutter/material.dart';

import '../../constants/custom_images.dart';
import 'home/home_models/products_model.dart';

class CategoriesScreen extends StatelessWidget {
  final List<ProductsModel> productsList;
  final String categoryName;
  const CategoriesScreen({
    super.key,
    required this.productsList,
    required this.categoryName,
  });

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
            style: textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    CustomImages.nike,
                    fit: BoxFit.fill,
                    height: 200,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: ProductsGridView(
                  productsList: productsList,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
