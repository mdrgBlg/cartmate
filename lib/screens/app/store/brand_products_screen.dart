import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '/models/brand_model.dart';
import '/models/products_model.dart';
import '/utils/constants/custom_colors.dart';
import '/widgets/custom_app_bar.dart';
import '/widgets/layouts/main_layout.dart';
import '/widgets/products_grid_view/products_grid_view.dart';
import 'providers/brand_products_provider.dart';
import 'widgets/brand_container.dart';

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
      backgroundColor: CustomColors.secondary,
      appBar: CustomAppBar(
        titleText: provider.brandModel.brandName,
        type: AppBarType.dark,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: BrandContainer(brand: provider.brandModel),
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
    return FutureBuilder<void>(
      future: provider.loadFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            heightFactor: 3,
            child: CircularProgressIndicator(),
          );
        }
        return Selector<BrandProductsProvider, (List<ProductsModel>, bool)>(
          selector: (_, provider) => (provider.products, provider.hasError),
          builder: (_, data, __) {
            final (products, hasError) = data;
            if (hasError) {
              return const Center(
                heightFactor: 3,
                // TODO(l10n): genericError
                child: Text("Something went wrong. Please try again"),
              );
            }
            return ProductsGridView(productsList: products);
          },
        );
      },
    );
  }
}
