import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '/core/l10n/app_localizations.dart';
import '/core/styles/app_spacing.dart';
import '/core/widgets/empty_state.dart';
import '/core/widgets/error_view.dart';
import '/core/widgets/layouts/main_layout.dart';
import '/core/widgets/main_header/main_header.dart';
import '/data/models/brand_model.dart';
import '/data/models/categories_model.dart';
import '/utils/assets/custom_illustrations.dart';
import '/utils/custom_navigator.dart';
import 'brand_products_screen.dart';
import 'providers/store_provider.dart';
import 'view_all_brands_screen.dart';
import 'widgets/brand_grid.dart';
import 'widgets/brand_grid_skeleton.dart';
import 'widgets/categories_brands.dart';
import 'widgets/categories_brands_skeleton.dart';
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
    final localization = AppLocalizations.of(context);
    final storeProvider = Provider.of<StoreProvider>(context, listen: false);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return MainLayout(
      showNavBar: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
              child: MainHeader(
                text: localization.storeTitle,
                contentColor: colorScheme.onSurface,
              ),
            ),
            Padding(
              padding: AppSpacing.screenPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localization.storeFeaturedBrands,
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
                    child: Text(
                      localization.storeViewAll,
                      style: textTheme.bodyMedium,
                    ),
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
                padding: const EdgeInsets.only(
                  left: AppSpacing.screenHorizontal,
                ),
                child:
                    Selector<StoreProvider, (List<CategoriesModel>, String?)>(
                      selector: (_, provider) =>
                          (provider.categories, provider.selectedCategory?.id),
                      builder: (_, data, _) {
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
            const Padding(
              padding: AppSpacing.screenPadding,
              child: Divider(thickness: 2, height: 1.5),
            ),
            const Gap(24),
            Selector<StoreProvider, Future<void>>(
              selector: (_, provider) => provider.loadFuture,
              builder: (_, future, _) => FutureBuilder<void>(
                future: future,
                builder: (_, snapshot) =>
                    snapshot.connectionState == ConnectionState.waiting
                    ? const Padding(
                        padding: AppSpacing.screenPadding,
                        child: CategoriesBrandsSkeleton(),
                      )
                    : Selector<StoreProvider, (List<BrandModel>, bool, bool)>(
                        selector: (_, provider) => (
                          provider.categoryBrands,
                          provider.hasProductsError ||
                              provider.hasCategoriesError,
                          provider.hasBrandsError,
                        ),
                        builder: (_, data, _) {
                          final (categoryBrands, hasError, hasBrandsError) =
                              data;
                          // The featured block already shows the error view.
                          if (hasBrandsError &&
                              (hasError || categoryBrands.isEmpty)) {
                            return const SizedBox.shrink();
                          }
                          if (hasError) {
                            return ErrorView(onRetry: storeProvider.reload);
                          }
                          if (categoryBrands.isEmpty) {
                            return EmptyState(
                              illustration: CustomIllustrations.noResults,
                              title: localization.storeEmptyTitle,
                              message: localization.storeEmptyMessage,
                            );
                          }
                          return Padding(
                            padding: AppSpacing.screenPadding,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: categoryBrands.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(
                                  bottom: AppSpacing.lg,
                                ),
                                child: CategoriesBrands(
                                  categoryBrand: categoryBrands[index],
                                  productsList: storeProvider
                                      .categoryProductsForBrand(
                                        categoryBrands[index],
                                      ),
                                  onTap: () =>
                                      CustomNavigator(context).pushNavigation(
                                        routeName:
                                            BrandProductsScreen.routeName,
                                        screen: BrandProductsScreen(
                                          categoryId: storeProvider
                                              .selectedCategory
                                              ?.id,
                                          brandModel: categoryBrands[index],
                                        ),
                                      ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
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
    final storeProvider = Provider.of<StoreProvider>(context, listen: false);
    return Selector<StoreProvider, Future<void>>(
      selector: (_, provider) => provider.loadFuture,
      builder: (_, future, _) => FutureBuilder<void>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const BrandGridSkeleton();
          }
          if (storeProvider.hasBrandsError) {
            return ErrorView(onRetry: storeProvider.reload);
          }
          if (storeProvider.brands.isEmpty) {
            return const SizedBox.shrink();
          }
          return BrandGrid(brandList: storeProvider.brands, showLimited: true);
        },
      ),
    );
  }
}
