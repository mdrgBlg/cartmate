import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../screen_wrapper.dart';
import '/constants/custom_colors.dart';
import '/providers/main_provider.dart';
import '/widgets/shopping_cart.dart';
import 'store_providers/store_provider.dart';
import 'store_widgets/brand_grid.dart';
import 'store_widgets/categories_brands.dart';
import 'store_widgets/categories_text_widget.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  static const routeName = '/store';

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(
      context,
      listen: false,
    );
    final storeProvider = Provider.of<StoreProvider>(
      context,
      listen: false,
    );
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: ScreenWrapper(
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
                    ShoppingCart(
                      productNumber: mainProvider.cartProductNumber,
                      homeScreen: false,
                    )
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
                    Text(
                      "View all",
                      style: textTheme.bodyMedium,
                    )
                  ],
                ),
              ),
              FutureBuilder<void>(
                future: storeProvider.fetchBrands(),
                builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : storeProvider.brandsList.isNotEmpty
                        ? BrandGrid(brandList: storeProvider.brandsList)
                        : Container(),
              ),
              const Gap(32),
              SizedBox(
                height: 40,
                child: FutureBuilder<void>(
                  future: storeProvider.fetchCategories(mainProvider.whishlistProductsList),
                  builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
                      ? const Center(child: CircularProgressIndicator())
                      : Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            controller: storeProvider.scrollController,
                            itemCount: storeProvider.categoriesList.length,
                            itemBuilder: (context, index) => Consumer<StoreProvider>(
                              builder: (_, __, child) => CategoriesTextWidget(
                                categoriesModel: storeProvider.categoriesList[index],
                                onTap: () => storeProvider.changeSelectedCategory(storeProvider.categoriesList[index]),
                                isActive: storeProvider.selectedCategory == storeProvider.categoriesList[index],
                              ),
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
                  color: CustomColors.text.withOpacity(0.2),
                ),
              ),
              const Gap(24),
              Consumer<StoreProvider>(
                builder: (_, __, child) => storeProvider.categoriesList.isNotEmpty
                    ? Padding(
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
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
