import 'package:e_commerce/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../screen_wrapper.dart';
import '/constants/custom_colors.dart';
import '/providers/main_provider.dart';
import '/widgets/search_field.dart';
import 'home_providers/home_provider.dart';
import 'home_widgets/custom_curved_edges.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/';

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
        child: Column(
          children: [
            ClipPath(
              clipper: CustomCurvedEdges(),
              child: Container(
                height: 360,
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 48, 20, 0),
                      child: SearchField(
                        searchController: homeProvider.searchController,
                        hintText: "Search...",
                        onChanged: (p0) {},
                        clearInput: homeProvider.searchController.clear,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
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
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        controller: homeProvider.scrollController,
                        itemCount: 7,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            children: [
                              Container(
                                height: 48,
                                width: 48,
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(99),
                                  color: Colors.white,
                                ),
                                child: Image.asset(
                                  CustomIcons.sports,
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  width: 44,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    "Furniture",
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
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
