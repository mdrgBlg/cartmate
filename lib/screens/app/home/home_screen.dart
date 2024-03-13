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
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
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
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            "${mainProvider.userInfoModel?.firstName ?? ""} ${mainProvider.userInfoModel?.lastName ?? ""}",
                            style: textTheme.titleLarge!.copyWith(
                              color: CustomColors.secondary,
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 28,
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: SearchField(
                        searchController: homeProvider.searchController,
                        hintText: "Search...",
                        onChanged: (p0) {},
                        clearInput: homeProvider.searchController.clear,
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
