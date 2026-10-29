import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/core/l10n/app_localizations.dart';
import '/core/styles/app_radius.dart';
import '/core/styles/app_spacing.dart';
import '/core/widgets/error_view.dart';
import '/core/widgets/layouts/main_layout.dart';
import '/core/widgets/main_header/main_header.dart';
import '/core/widgets/products_grid_view/products_grid_view.dart';
import '/core/widgets/products_grid_view/widgets/products_grid_skeleton.dart';
import '/core/widgets/search_field/search_field.dart';
import '/data/models/categories_model.dart';
import '/utils/custom_navigator.dart';
import 'categories_screen.dart';
import 'providers/home_provider.dart';
import 'widgets/categories_list.dart';
import 'widgets/categories_skeleton.dart';
import 'widgets/home_banner_carousel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => HomeProvider(
        userRepository: ctx.read(),
        wishlistRepository: ctx.read(),
        productRepository: ctx.read(),
      ),
      child: const _HomeScreen(),
    );
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return MainLayout(
      showNavBar: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: AppSpacing.xl),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: colorScheme.primary,
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MainHeader(
                      text: homeProvider.userInfoModel?.fullName ?? '',
                    ),
                    const _HomeSearchAndCategories(),
                  ],
                ),
              ),
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(color: colorScheme.primary),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: AppSpacing.md),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(AppRadius.xl),
                    ),
                    color: colorScheme.surfaceContainerLowest,
                  ),
                  child: Column(
                    children: [
                      const HomeBannerCarousel(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.screenHorizontal,
                          AppSpacing.xxxl,
                          AppSpacing.screenHorizontal,
                          AppSpacing.xl,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              localization.homePopularProducts,
                              style: textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Selector<HomeProvider, Future<void>>(
                        selector: (_, provider) => provider.productsFuture,
                        builder: (_, future, _) => FutureBuilder<void>(
                          future: future,
                          builder: (context, snapshot) =>
                              snapshot.connectionState ==
                                  ConnectionState.waiting
                              ? const ProductsGridSkeleton()
                              : homeProvider.hasProductsError
                              ? ErrorView(onRetry: homeProvider.reloadProducts)
                              : Consumer<HomeProvider>(
                                  builder: (context, value, child) =>
                                      ProductsGridView(
                                        productsList: homeProvider.products,
                                      ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeSearchAndCategories extends StatelessWidget {
  const _HomeSearchAndCategories();
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenHorizontal,
                94,
                AppSpacing.screenHorizontal,
                0,
              ),
              child: Text(
                localization.homePopularCategories,
                style: textTheme.bodyLarge!.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: AppSpacing.lg),
              height: 72,
              child: Selector<HomeProvider, Future<List<CategoriesModel>>>(
                selector: (_, provider) => provider.categoriesFuture,
                builder: (_, future, _) => FutureBuilder<List<CategoriesModel>>(
                  future: future,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CategoriesSkeleton();
                    }
                    if (homeProvider.hasCategoriesError) {
                      return Padding(
                        padding: AppSpacing.screenPadding,
                        child: ErrorView(
                          compact: true,
                          foregroundColor: colorScheme.onPrimary,
                          onRetry: homeProvider.reloadCategories,
                        ),
                      );
                    }
                    final categories =
                        snapshot.data ?? const <CategoriesModel>[];
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      controller: homeProvider.scrollController,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return CategoriesList(
                          categoriesModel: category,
                          onTap: () => CustomNavigator(context).pushNavigation(
                            routeName: CategoriesScreen.routeName,
                            screen: CategoriesScreen(
                              productsList: homeProvider.getProductsForCategory(
                                category.id,
                              ),
                              categoryName: category.categoryName,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenHorizontal,
            AppSpacing.xl,
            AppSpacing.screenHorizontal,
            0,
          ),
          child: SearchField(hintText: localization.homeSearchHint),
        ),
      ],
    );
  }
}
