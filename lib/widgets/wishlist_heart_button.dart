import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/wishlist_heart_provider.dart';
import '../models/products_model.dart';

class WishlistHeartButton extends StatelessWidget {
  const WishlistHeartButton({required this.product, super.key});

  final ProductsModel product;

  @override
  Widget build(BuildContext context) {
    // The key recreates the provider when the owning list provider hands in a
    // product with a different flag (or a different product).
    return ChangeNotifierProvider(
      key: ValueKey('${product.id}:${product.whishlist}'),
      create: (context) => WishlistHeartProvider(
        wishlistRepository: context.read(),
        product: product,
      ),
      child: const _HeartView(),
    );
  }
}

class _HeartView extends StatelessWidget {
  const _HeartView();

  @override
  Widget build(BuildContext context) {
    return Consumer<WishlistHeartProvider>(
      builder: (_, heart, __) => InkWell(
        onTap: heart.toggle,
        borderRadius: BorderRadius.circular(99),
        child: Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(99),
            color: Colors.grey.withValues(alpha: 0.2),
          ),
          child: Icon(
            Icons.favorite,
            color: heart.isWishlisted ? Colors.red : Colors.grey,
          ),
        ),
      ),
    );
  }
}
