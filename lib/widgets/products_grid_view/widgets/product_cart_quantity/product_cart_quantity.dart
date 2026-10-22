import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/product_cart_quantity_provider.dart';

class ProductCartQuantity extends StatelessWidget {
  const ProductCartQuantity({required this.productId, super.key});

  final String productId;

  @override
  Widget build(BuildContext context) {
    // The key recreates the provider when the cell shows a different product.
    return ChangeNotifierProvider(
      key: ValueKey(productId),
      create: (context) => ProductCartQuantityProvider(
        cartRepository: context.read(),
        productId: productId,
      ),
      child: const _QuantityView(),
    );
  }
}

class _QuantityView extends StatelessWidget {
  const _QuantityView();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Consumer<ProductCartQuantityProvider>(
      builder: (_, provider, __) {
        final quantity = provider.quantity;
        return Text(
          quantity == 0 ? "+" : quantity.toString(),
          style: quantity == 0
              ? textTheme.titleLarge!.copyWith(color: Colors.white)
              : textTheme.titleMedium!.copyWith(color: Colors.white),
        );
      },
    );
  }
}
