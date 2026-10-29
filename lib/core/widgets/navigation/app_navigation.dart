import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/core/l10n/app_localizations.dart';
import '/screens/app/home/home_screen.dart';
import '/screens/app/profile/profile_screen.dart';
import '/screens/app/store/store_screen.dart';
import '/screens/app/wishlist/wishlist_screen.dart';
import '/utils/custom_navigator.dart';
import '../../styles/app_radius.dart';
import '../../styles/app_spacing.dart';
import 'widgets/navbar_item.dart';

class AppNavigation extends StatelessWidget {
  const AppNavigation({super.key});

  bool isTabActive({required String routeName, required String? currentRoute}) {
    return routeName == currentRoute;
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final colorScheme = Theme.of(context).colorScheme;
    return Wrap(
      children: [
        Container(
          padding: const EdgeInsets.only(
            top: AppSpacing.xs,
            bottom: AppSpacing.xxs,
          ),
          decoration: BoxDecoration(
            borderRadius: AppRadius.xxlAll,
            color: colorScheme.primary,
          ),
          child: Row(
            children: [
              Expanded(
                child: NavBarItem(
                  itemIcon: Icons.home,
                  itemText: localization.navHome,
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
                  itemText: localization.navStore,
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
                  itemText: localization.navWishlist,
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
                  itemText: localization.navProfile,
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
