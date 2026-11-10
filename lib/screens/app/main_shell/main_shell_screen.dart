import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/core/l10n/app_localizations.dart';
import '/core/providers/main_shell_provider.dart';
import '/screens/app/home/home_screen.dart';
import '/screens/app/profile/profile_screen.dart';
import '/screens/app/store/store_screen.dart';
import '/screens/app/wishlist/wishlist_screen.dart';
import '/screens/auth/welcome/welcome_screen.dart';

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  static const routeName = '/';

  /// True for the route hosting the shell. The shell is hosted by `'/'` on a
  /// cold start and after login, and by [WelcomeScreen.routeName] after
  /// sign-up, so both names are accepted (use with `Navigator.popUntil`).
  static bool isShellRoute(Route<dynamic> route) {
    final name = route.settings.name;
    return name == routeName || name == WelcomeScreen.routeName;
  }

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  // Order = destination order; index 0 is MainShellProvider.homeIndex.
  static const _tabs = <Widget>[
    HomeScreen(),
    StoreScreen(),
    WishlistScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    Provider.of<MainShellProvider>(context, listen: false).reset();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Consumer<MainShellProvider>(
      builder: (context, shell, _) => PopScope(
        canPop: shell.currentIndex == MainShellProvider.homeIndex,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) {
            shell.selectTab(MainShellProvider.homeIndex);
          }
        },
        child: Scaffold(
          body: IndexedStack(
            index: shell.currentIndex,
            children: [
              for (var i = 0; i < _tabs.length; i++)
                shell.isVisited(i)
                    ? TickerMode(
                        enabled: i == shell.currentIndex,
                        child: PrimaryScrollController.none(child: _tabs[i]),
                      )
                    : const SizedBox.shrink(),
            ],
          ),
          // Foreground: NavigationBar paints an opaque surface background
          // that would hide a background-positioned border.
          bottomNavigationBar: DecoratedBox(
            position: DecorationPosition.foreground,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: colorScheme.outlineVariant),
              ),
            ),
            child: NavigationBar(
              selectedIndex: shell.currentIndex,
              onDestinationSelected: (index) {
                // A kept-alive tab must not keep focus / keyboard while hidden.
                FocusManager.instance.primaryFocus?.unfocus();
                shell.selectTab(index);
              },
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.home_outlined),
                  selectedIcon: const Icon(Icons.home),
                  label: localization.navHome,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.storefront_outlined),
                  selectedIcon: const Icon(Icons.storefront),
                  label: localization.navStore,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.favorite_border),
                  selectedIcon: const Icon(Icons.favorite),
                  label: localization.navWishlist,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.person_outline),
                  selectedIcon: const Icon(Icons.person),
                  label: localization.navProfile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
