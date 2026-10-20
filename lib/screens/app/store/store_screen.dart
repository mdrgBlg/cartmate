import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '/constants/custom_colors.dart';
import '/providers/main_provider.dart';
import '/utils/custom_navigator.dart';
import '/widgets/main_layout.dart';
import '/widgets/shopping_cart.dart';
import '../checkout/cart_screen.dart';
import 'store_providers/store_provider.dart';
import 'store_widgets/brand_grid.dart';
import 'store_widgets/categories_brands.dart';
import 'store_widgets/categories_text_widget.dart';
import 'store_widgets/view_all_brands.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  static const routeName = '/store';

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final storeProvider = Provider.of<StoreProvider>(context, listen: false);
    final textTheme = Theme.of(context).textTheme;
    return MainLayout(
      showNavBar: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                20,
                mainProvider.cartProductNumber > 0 ? 20 : 12,
                0,
              ),
              child: Row(
                children: [
                  Text(
                    "Store",
                    style: textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () => CustomNavigator(context).pushNavigation(
                      routeName: CartScreen.routeName,
                      screen: const CartScreen(),
                    ),
                    child: Consumer<MainProvider>(
                      builder: (_, __, child) => ShoppingCart(
                        productNumber: mainProvider.cartProductNumber,
                        homeScreen: false,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Featured Brands",
                    style: textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () => CustomNavigator(context).pushNavigation(
                      routeName: ViewAllBrands.routeName,
                      screen: ChangeNotifierProvider.value(
                        value: storeProvider,
                        child: ViewAllBrands(
                          brandsList: storeProvider.brandsList,
                        ),
                      ),
                    ),
                    child: Text("View all", style: textTheme.bodyMedium),
                  ),
                ],
              ),
            ),
            FutureBuilder<void>(
              future: storeProvider.fetchBrands(),
              builder: (context, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      heightFactor: 3,
                      child: CircularProgressIndicator(),
                    )
                  : storeProvider.hasError
                  // TODO(l10n): storeError
                  ? const Center(
                      heightFactor: 3,
                      child: Text("Something went wrong. Please try again"),
                    )
                  : storeProvider.brandsList.isNotEmpty
                  ? BrandGrid(
                      brandList: storeProvider.brandsList,
                      showLimited: true,
                    )
                  : Container(),
            ),
            const Gap(32),
            SizedBox(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Consumer<StoreProvider>(
                  builder: (_, __, child) => ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    controller: storeProvider.scrollController,
                    itemCount: storeProvider.categoriesList.length,
                    itemBuilder: (context, index) => CategoriesTextWidget(
                      categoriesModel: storeProvider.categoriesList[index],
                      onTap: () => storeProvider.changeSelectedCategory(
                        storeProvider.categoriesList[index],
                      ),
                      isActive:
                          storeProvider.selectedCategory ==
                          storeProvider.categoriesList[index],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Divider(
                thickness: 2,
                height: 1.5,
                color: CustomColors.text.withValues(alpha: 0.2),
              ),
            ),
            const Gap(24),
            Consumer<StoreProvider>(
              builder: (_, __, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: storeProvider.categoryBrandsList.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: CategoriesBrands(
                        categoryBrand: storeProvider.categoryBrandsList[index],
                        brandProducts: storeProvider.brandProducts,
                        productsList: storeProvider.getProducts(
                          storeProvider.categoryBrandsList[index],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
