import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/constants/custom_colors.dart';
import '/providers/main_provider.dart';
import '/screens/app/checkout/cart_screen.dart';
import '/utils/custom_navigator.dart';
import '/widgets/main_layout.dart';
import '/widgets/products_grid_view.dart';
import '/widgets/search_field.dart';
import '/widgets/shopping_cart.dart';
import 'home_models/categories_model.dart';
import 'home_providers/home_provider.dart';
import 'home_widgets/categories_widget.dart';
import 'home_widgets/home_banner_carousel.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final textTheme = Theme.of(context).textTheme;
    return MainLayout(
      showNavBar: true,
      child: GestureDetector(
        // Unfocusing the search field reports the change to its provider.
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: CustomColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: mainProvider.cartProductNumber > 0 ? 20 : 12,
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(
                              homeProvider.userInfoModel?.fullName ?? '',
                              style: textTheme.titleLarge!.copyWith(
                                color: CustomColors.secondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () =>
                                CustomNavigator(context).pushNavigation(
                                  routeName: CartScreen.routeName,
                                  screen: const CartScreen(),
                                ),
                            child: Consumer<MainProvider>(
                              builder: (_, __, child) => ShoppingCart(
                                productNumber: mainProvider.cartProductNumber,
                                homeScreen: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                20,
                                108,
                                20,
                                0,
                              ),
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
                                    snapshot.connectionState ==
                                        ConnectionState.waiting
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        controller:
                                            homeProvider.scrollController,
                                        itemCount: snapshot.data?.length,
                                        itemBuilder: (context, index) =>
                                            CategoriesWidget(
                                              categoriesModel:
                                                  snapshot.data![index],
                                            ),
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
                    ),
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
