import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '/core/styles/app_spacing.dart';
import '/core/widgets/custom_app_bar.dart';
import '/core/widgets/error_view.dart';
import '/core/widgets/layouts/main_layout.dart';
import '/core/widgets/products_grid_view/products_grid_view.dart';
import '/core/widgets/products_grid_view/widgets/products_grid_skeleton.dart';
import '/data/models/brand_model.dart';
import '/data/models/products_model.dart';
import 'providers/brand_products_provider.dart';
import 'widgets/brand_tile.dart';

/// Expects a [BrandProductsProvider] above it.
class BrandProductsScreen extends StatelessWidget {
  const BrandProductsScreen({
    required this.brandModel,
    this.categoryId,
    super.key,
  });

  final String? categoryId;
  final BrandModel brandModel;

  static const routeName = '/brandProducts';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => BrandProductsProvider(
        brandModel: brandModel,
        categoryId: categoryId,
        productRepository: ctx.read(),
        wishlistRepository: ctx.read(),
      ),
      child: const _BrandProductsScreen(),
    );
  }
}

class _BrandProductsScreen extends StatelessWidget {
  const _BrandProductsScreen();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BrandProductsProvider>(context, listen: false);

    return MainLayout(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      appBar: CustomAppBar(
        titleText: provider.brandModel.brandName,
        type: AppBarType.dark,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenHorizontal,
              vertical: AppSpacing.md,
            ),
            child: BrandTile(
              brand: provider.brandModel,
              padding: const EdgeInsets.only(
                left: AppSpacing.lg,
                top: AppSpacing.md,
                bottom: AppSpacing.md,
              ),
            ),
          ),
          const Gap(12),
          const _BrandProducts(),
        ],
      ),
    );
  }
}

class _BrandProducts extends StatelessWidget {
  const _BrandProducts();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BrandProductsProvider>(context, listen: false);
    return Selector<BrandProductsProvider, Future<void>>(
      selector: (_, provider) => provider.loadFuture,
      builder: (_, future, _) => FutureBuilder<void>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Expanded(child: ProductsGridSkeleton());
          }
          return Selector<BrandProductsProvider, (List<ProductsModel>, bool)>(
            selector: (_, provider) => (provider.products, provider.hasError),
            builder: (_, data, _) {
              final (products, hasError) = data;
              if (hasError) {
                return ErrorView(onRetry: provider.reload);
              }
              return ProductsGridView(productsList: products);
            },
          );
        },
      ),
    );
  }
}
