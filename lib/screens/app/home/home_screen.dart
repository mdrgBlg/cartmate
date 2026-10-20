import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/constants/custom_colors.dart';
import '/models/categories_model.dart';
import '/utils/custom_navigator.dart';
import '/widgets/main_header.dart';
import '/widgets/main_layout.dart';
import '/widgets/products_grid_view/products_grid_view.dart';
import '/widgets/search_field.dart';
import '../categories_screen.dart';
import 'home_providers/home_provider.dart';
import 'home_widgets/categories_list.dart';
import 'home_widgets/home_banner_carousel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final textTheme = Theme.of(context).textTheme;

    return MainLayout(
      showNavBar: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: CustomColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 20),
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
                decoration: const BoxDecoration(color: CustomColors.primary),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 12),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      const HomeBannerCarousel(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 32, 20, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Popular Products",
                              style: textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      FutureBuilder<void>(
                        future: homeProvider.productsFuture,
                        builder: (context, snapshot) =>
                            snapshot.connectionState == ConnectionState.waiting
                            ? const Center(child: CircularProgressIndicator())
                            : homeProvider.hasProductsError
                            ? const Center(
                                child: Text(
                                  "Something went wrong. Please try again",
                                ),
                              )
                            : Consumer<HomeProvider>(
                                builder: (context, value, child) =>
                                    ProductsGridView(
                                      productsList: homeProvider.products,
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
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 94, 20, 0),
              child: Text(
                "Popular Categories",
                style: textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              height: 72,
              child: FutureBuilder<List<CategoriesModel>>(
                future: homeProvider.categoriesFuture,
                builder: (context, snapshot) =>
                    snapshot.connectionState == ConnectionState.waiting
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        controller: homeProvider.scrollController,
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          final category = snapshot.data![index];
                          return CategoriesList(
                            categoriesModel: category,
                            onTap: () =>
                                CustomNavigator(context).pushNavigation(
                                  routeName: CategoriesScreen.routeName,
                                  screen: CategoriesScreen(
                                    productsList: homeProvider
                                        .getProductsForCategory(category.id),
                                    categoryName: category.categoryName,
                                  ),
                                ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: SearchField(hintText: "Search product..."),
        ),
      ],
    );
  }
}
