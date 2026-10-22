import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/screens/app/home/home_screen.dart';
import '/screens/app/profile/profile_screen.dart';
import '/screens/app/store/store_screen.dart';
import '/screens/app/wishlist/wishlist_screen.dart';
import '/utils/constants/custom_colors.dart';
import '/utils/custom_navigator.dart';
import 'widgets/navbar_item.dart';

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
            children: [
              Expanded(
                child: NavBarItem(
                  itemIcon: Icons.home,
                  itemText: "Home",
                  onTap: () => CustomNavigator(context).pushReplacement(
                    routeName: HomeScreen.routeName,
                    screen: const HomeScreen(),
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
                  onTap: () => CustomNavigator(context).pushReplacement(
                    routeName: StoreScreen.routeName,
                    screen: const StoreScreen(),
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
                  onTap: () => CustomNavigator(context).pushReplacement(
                    routeName: WishlistScreen.routeName,
                    screen: const WishlistScreen(),
                  ),
                  active: isTabActive(
                    routeName: WishlistScreen.routeName,
                    currentRoute: currentRoute,
                  ),
                ),
              ),
              Expanded(
                child: NavBarItem(
                  itemIcon: CupertinoIcons.profile_circled,
                  itemText: "Profile",
                  onTap: () => CustomNavigator(context).pushReplacement(
                    routeName: ProfileScreen.routeName,
                    screen: const ProfileScreen(),
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
