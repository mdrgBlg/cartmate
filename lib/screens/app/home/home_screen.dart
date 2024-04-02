import 'package:e_commerce/constants/custom_images.dart';
import 'package:e_commerce/screens/app/home/home_models/categories_model.dart';
import 'package:e_commerce/screens/app/home/home_widgets/categories_widget.dart';
import 'package:e_commerce/screens/app/home/home_widgets/custom_product_card.dart';
import 'package:e_commerce/screens/app/home/home_widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../../screen_wrapper.dart';
import '/constants/custom_colors.dart';
import '/providers/main_provider.dart';
import '/widgets/search_field.dart';
import 'home_providers/home_provider.dart';
import 'home_widgets/custom_curved_edges.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  static const routeName = '/';

  final debouncer = Debouncer(
    delay: const Duration(
      milliseconds: 600,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(
      context,
      listen: false,
    );
    final homeProvider = Provider.of<HomeProvider>(
      context,
      listen: false,
    );
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: ScreenWrapper(
        child: GestureDetector(
          onTap: () => {
            FocusScope.of(context).requestFocus(FocusNode()),
            homeProvider.focusChange(false),
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                ClipPath(
                  clipper: CustomCurvedEdges(),
                  child: Container(
                    height: 320,
                    width: double.infinity,
                    color: CustomColors.primary,
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 12,
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Text(
                                  "${mainProvider.userInfoModel?.firstName ?? ""} ${mainProvider.userInfoModel?.lastName ?? ""}",
                                  style: textTheme.titleLarge!.copyWith(
                                    color: CustomColors.secondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                height: 48,
                                width: 44,
                                child: Stack(
                                  alignment: Alignment.centerLeft,
                                  children: [
                                    const Icon(
                                      Icons.shopping_cart,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: Container(
                                        height: 18,
                                        width: 18,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(99),
                                          color: Colors.black,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "2",
                                            style: textTheme.labelLarge!.copyWith(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 108, 20, 0),
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
                                    future: homeProvider.fetchCategories(),
                                    builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
                                        ? const Center(child: CircularProgressIndicator())
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            controller: homeProvider.scrollController,
                                            itemCount: snapshot.data?.length,
                                            itemBuilder: (context, index) => CategoriesWidget(
                                              categoryName: snapshot.data![index].categoryName,
                                              icon: snapshot.data![index].iconName,
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: Consumer<HomeProvider>(
                                builder: (_, __, child) => SearchField(
                                  searchController: homeProvider.searchController,
                                  hintText: "Search...",
                                  onChanged: (value) {
                                    if (value.isEmpty) {
                                      debouncer.call(() {
                                        homeProvider.clearInput();
                                      });
                                    } else {
                                      debouncer.call(() {
                                        homeProvider.searchProduct(value);
                                      });
                                    }
                                  },
                                  clearInput: homeProvider.clearInput,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 250,
                  child: PageView.builder(
                    itemCount: CustomImages.homeImages.length,
                    onPageChanged: (value) => homeProvider.changeScreenIndex(value),
                    itemBuilder: (_, index) => Container(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          CustomImages.homeImages[index],
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                Consumer<HomeProvider>(
                  builder: (_, __, child) => CustomProgressIndicator(
                    screenIndex: homeProvider.screenIndex,
                  ),
                ),
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
                      Text(
                        "View all",
                        style: textTheme.bodyMedium,
                      )
                    ],
                  ),
                ),
                FutureBuilder<void>(
                  future: homeProvider.fetchProducts(),
                  builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              mainAxisExtent: 263,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: homeProvider.productsList.length,
                            itemBuilder: (context, index) => homeProvider.productsList.isNotEmpty
                                ? CustomProductCard(
                                    productsModel: homeProvider.productsList[index],
                                  )
                                : null,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
