import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/core/l10n/app_localizations.dart';
import '/core/styles/app_spacing.dart';
import '/core/widgets/layouts/main_layout.dart';
import '/core/widgets/products_grid_view/products_grid_view.dart';
import '/core/widgets/products_grid_view/widgets/products_grid_skeleton.dart';
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
    final provider = Provider.of<WishlistProvider>(context, listen: false);
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
              FutureBuilder(
                future: provider.wishlistFuture,
                builder: (context, snapshot) =>
                    snapshot.connectionState == ConnectionState.waiting
                    ? const ProductsGridSkeleton()
                    : snapshot.data == null
                    ? Consumer<WishlistProvider>(
                        builder: (_, wishlistProvider, child) =>
                            ProductsGridView(
                              productsList: wishlistProvider.products,
                            ),
                      )
                    :
                      /// TODO Handle error
                      Text(localization.wishlistError),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
