import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/core/l10n/app_localizations.dart';
import '/core/styles/app_spacing.dart';
import '/core/widgets/empty_state.dart';
import '/core/widgets/error_view.dart';
import '/core/widgets/layouts/main_layout.dart';
import '/core/widgets/products_grid_view/products_grid_view.dart';
import '/core/widgets/products_grid_view/widgets/products_grid_skeleton.dart';
import '/screens/app/home/home_screen.dart';
import '/utils/assets/custom_illustrations.dart';
import '/utils/custom_navigator.dart';
import 'providers/wishlist_provider.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  static const routeName = '/wishlist';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WishlistProvider(wishlistRepository: context.read()),
      child: const _WishlistScreen(),
    );
  }
}

class _WishlistScreen extends StatelessWidget {
  const _WishlistScreen();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    return MainLayout(
      showNavBar: true,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 28),
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: AppSpacing.screenPadding,
                child: Text(
                  localization.wishlistTitle,
                  style: textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Selector<WishlistProvider, Future<Exception?>>(
                selector: (_, provider) => provider.wishlistFuture,
                builder: (_, future, _) => FutureBuilder(
                  future: future,
                  builder: (context, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                      ? const ProductsGridSkeleton()
                      : Consumer<WishlistProvider>(
                          builder: (_, wishlistProvider, child) =>
                              wishlistProvider.hasError
                              ? ErrorView(onRetry: wishlistProvider.reload)
                              : wishlistProvider.products.isEmpty
                              ? EmptyState(
                                  illustration:
                                      CustomIllustrations.emptyWishlist,
                                  title: localization.wishlistEmptyTitle,
                                  message: localization.wishlistEmptyMessage,
                                  actionLabel: localization.startShopping,
                                  onAction: () =>
                                      CustomNavigator(context).pushReplacement(
                                        routeName: HomeScreen.routeName,
                                        screen: const HomeScreen(),
                                      ),
                                )
                              : ProductsGridView(
                                  productsList: wishlistProvider.products,
                                ),
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
