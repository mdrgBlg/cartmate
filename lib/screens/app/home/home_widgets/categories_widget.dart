import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../categories_screen.dart';
import '../home_models/categories_model.dart';
import '../home_models/products_model.dart';
import '../home_providers/home_provider.dart';
import '/helpers/custom_navigator.dart';
import '/providers/main_provider.dart';

class CategoriesWidget extends StatelessWidget {
  final CategoriesModel categoriesModel;

  const CategoriesWidget({
    super.key,
    required this.categoriesModel,
  });

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(
      context,
      listen: false,
    );
    final mainProvider = Provider.of<MainProvider>(
      context,
      listen: false,
    );
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 14),
      child: InkWell(
        onTap: () {
          List<ProductsModel> categoryProducts =
              homeProvider.getProductsForCategory(
            categoriesModel.id,
            mainProvider.productsList,
          );
          CustomNavigator.pushNavigation(
            context: context,
            routeName: CategoriesScreen.routeName,
            screen: ChangeNotifierProvider.value(
              value: homeProvider,
              child: CategoriesScreen(
                productsList: categoryProducts,
                categoryName: categoriesModel.categoryName,
              ),
            ),
          );
        },
        child: Column(
          children: [
            Container(
              height: 48,
              width: 48,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(99),
                color: Colors.white,
              ),
              child: Image.asset(
                categoriesModel.iconName,
              ),
            ),
            Flexible(
              child: Container(
                width: 56,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  categoriesModel.categoryName,
                  style: textTheme.bodySmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
