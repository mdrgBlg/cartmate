import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '/core/styles/custom_colors.dart';
import '/core/widgets/layouts/main_layout.dart';
import '/core/widgets/main_header/main_header.dart';
import '/models/brand_model.dart';
import '/models/categories_model.dart';
import '/utils/custom_navigator.dart';
import 'brand_products_screen.dart';
import 'providers/store_provider.dart';
import 'view_all_brands_screen.dart';
import 'widgets/brand_grid.dart';
import 'widgets/categories_brands.dart';
import 'widgets/category_tab.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  static const routeName = '/store';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StoreProvider(
        wishlistRepository: context.read(),
        productRepository: context.read(),
      ),
      child: const _StoreScreen(),
    );
  }
}

class _StoreScreen extends StatelessWidget {
  const _StoreScreen();

  @override
  Widget build(BuildContext context) {
    final storeProvider = Provider.of<StoreProvider>(context, listen: false);
    final textTheme = Theme.of(context).textTheme;
    return MainLayout(
      showNavBar: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: MainHeader(text: "Store", contentColor: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      screen: ViewAllBrandsScreen(
                        brandsList: storeProvider.brands,
                      ),
                    ),
                    child: Text("View all", style: textTheme.bodyMedium),
                  ),
                ],
              ),
            ),
            const Gap(20),
            const _FeaturedBrands(),
            const Gap(32),
            SizedBox(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child:
                    Selector<StoreProvider, (List<CategoriesModel>, String?)>(
                      selector: (_, provider) =>
                          (provider.categories, provider.selectedCategory?.id),
                      builder: (_, data, __) {
                        final (categories, selectedId) = data;
                        return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            return CategoryTab(
                              categoryName: category.categoryName,
                              onTap: () => storeProvider.changeSelectedCategory(
                                category,
                              ),
                              isActive: selectedId == category.id,
                            );
                          },
                        );
                      },
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
            Selector<StoreProvider, (List<BrandModel>, bool)>(
              selector: (_, provider) => (
                provider.categoryBrands,
                provider.hasProductsError || provider.hasCategoriesError,
              ),
              builder: (_, data, __) {
                final (categoryBrands, hasError) = data;
                if (hasError) {
                  return const Center(
                    heightFactor: 3,
                    child: Text("Something went wrong. Please try again"),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: categoryBrands.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: CategoriesBrands(
                        categoryBrand: categoryBrands[index],
                        productsList: storeProvider.categoryProductsForBrand(
                          categoryBrands[index],
                        ),
                        onTap: () => CustomNavigator(context).pushNavigation(
                          routeName: BrandProductsScreen.routeName,
                          screen: BrandProductsScreen(
                            categoryId: storeProvider.selectedCategory?.id,
                            brandModel: categoryBrands[index],
                          ),
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

class _FeaturedBrands extends StatelessWidget {
  const _FeaturedBrands();

  @override
  Widget build(BuildContext context) {
    final storeProvider = context.read<StoreProvider>();
    return FutureBuilder<void>(
      future: storeProvider.loadFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            heightFactor: 3,
            child: CircularProgressIndicator(),
          );
        }
        if (storeProvider.hasBrandsError) {
          return const Center(
            heightFactor: 3,
            child: Text("Something went wrong. Please try again"),
          );
        }
        if (storeProvider.brands.isEmpty) {
          return const SizedBox.shrink();
        }
        return BrandGrid(brandList: storeProvider.brands, showLimited: true);
      },
    );
  }
}
