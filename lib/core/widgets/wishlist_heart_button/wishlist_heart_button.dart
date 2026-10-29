import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/core/l10n/app_localizations.dart';
import '/data/models/products_model.dart';
import '/utils/snack_bar_popup.dart';
import '../../styles/app_radius.dart';
import 'providers/wishlist_heart_provider.dart';

class WishlistHeartButton extends StatelessWidget {
  const WishlistHeartButton({required this.product, super.key});

  final ProductsModel product;

  @override
  Widget build(BuildContext context) {
    // The key recreates the provider when the owning list provider hands in a
    // product with a different flag (or a different product).
    return ChangeNotifierProvider(
      key: ValueKey('${product.id}:${product.isWishlisted}'),
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
    final colorScheme = Theme.of(context).colorScheme;

    return Consumer<WishlistHeartProvider>(
      builder: (context, heart, _) => InkWell(
        onTap: () => _toggle(context),
        borderRadius: AppRadius.pillAll,
        child: Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            borderRadius: AppRadius.pillAll,
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.2),
          ),
          child: Icon(
            Icons.favorite,
            color: heart.isWishlisted
                ? colorScheme.error
                : colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  // A successful toggle disposes this provider via the `ValueKey`, hence the
  // `mounted` check.
  void _toggle(BuildContext context) {
    final provider = Provider.of<WishlistHeartProvider>(context, listen: false);
    provider.toggle().then((success) {
      if (!success && context.mounted) {
        SnackBarPopup.showMessage(
          context,
          message: AppLocalizations.of(context).somethingWentWrong,
          snackBarMessageType: SnackBarMessageType.error,
        );
      }
    });
  }
}
