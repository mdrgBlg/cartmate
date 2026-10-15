import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/constants/custom_colors.dart';
import '/utils/custom_navigator.dart';
import 'app/home/home_providers/home_provider.dart';
import 'app/home/home_screen.dart';
import 'app/profile/profile_providers/profile_provider.dart';
import 'app/profile/profile_screen.dart';
import 'app/store/store_providers/store_provider.dart';
import 'app/store/store_screen.dart';
import 'app/whishlist/whishlist_screen.dart';
import 'navbar_item.dart';

class AppNavigation extends StatelessWidget {
  const AppNavigation({super.key});

  bool isTabActive({required String routeName, required String? currentRoute}) {
    return routeName == currentRoute;
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    return Wrap(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 4, bottom: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: CustomColors.primary,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: NavBarItem(
                  itemIcon: Icons.home,
                  itemText: "Home",
                  onTap: () => CustomNavigator(context).pushNavigation(
                    routeName: HomeScreen.routeName,
                    screen: ChangeNotifierProvider(
                      create: (_) => HomeProvider(),
                      child: HomeScreen(),
                    ),
                  ),
                  active: isTabActive(
                    routeName: HomeScreen.routeName,
                    currentRoute: currentRoute,
                  ),
                ),
              ),
              Expanded(
                child: NavBarItem(
                  itemIcon: Icons.store,
                  itemText: "Store",
                  onTap: () => CustomNavigator(context).pushNavigation(
                    routeName: StoreScreen.routeName,
                    screen: ChangeNotifierProvider(
                      create: (_) => StoreProvider(),
                      child: const StoreScreen(),
                    ),
                  ),
                  active: isTabActive(
                    routeName: StoreScreen.routeName,
                    currentRoute: currentRoute,
                  ),
                ),
              ),
              Expanded(
                child: NavBarItem(
                  itemIcon: CupertinoIcons.heart,
                  itemText: "Wishlist",
                  onTap: () => CustomNavigator(context).pushNavigation(
                    routeName: WhishlistScreen.routeName,
                    screen: const WhishlistScreen(),
                  ),
                  active: isTabActive(
                    routeName: WhishlistScreen.routeName,
                    currentRoute: currentRoute,
                  ),
                ),
              ),
              Expanded(
                child: NavBarItem(
                  itemIcon: CupertinoIcons.profile_circled,
                  itemText: "Profile",
                  onTap: () => CustomNavigator(context).pushNavigation(
                    routeName: ProfileScreen.routeName,
                    screen: ChangeNotifierProvider(
                      create: (_) =>
                          ProfileProvider(authRepository: context.read()),
                      child: const ProfileScreen(),
                    ),
                  ),
                  active: isTabActive(
                    routeName: ProfileScreen.routeName,
                    currentRoute: currentRoute,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
