import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/core/l10n/app_localizations.dart';
import '/core/styles/custom_colors.dart';
import '/core/widgets/app_network_image.dart';
import '/core/widgets/custom_app_bar.dart';
import '/core/widgets/custom_button.dart';
import '/core/widgets/layouts/main_layout.dart';
import '/core/widgets/wishlist_heart_button/wishlist_heart_button.dart';
import '/models/cart_model.dart';
import '/models/products_model.dart';
import '/utils/extensions/price_extension.dart';
import '/utils/snack_bar_popup.dart';
import 'providers/product_details_provider.dart';
import 'widgets/product_image_gallery.dart';
import 'widgets/product_size_selector/product_size_selector.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({required this.productsModel, super.key});
  final ProductsModel productsModel;

  static const routeName = '/details';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => ProductDetailsProvider(
        wishlistRepository: ctx.read(),
        cartRepository: ctx.read(),
        product: productsModel,
      ),
      child: const _ProductDetailsScreen(),
    );
  }
}

class _ProductDetailsScreen extends StatelessWidget {
  const _ProductDetailsScreen();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final provider = Provider.of<ProductDetailsProvider>(
      context,
      listen: false,
    );
    final textTheme = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context).toString();

    return MainLayout(
      appBar: CustomAppBar(
        type: AppBarType.dark,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Selector<ProductDetailsProvider, ProductsModel>(
              selector: (_, provider) => provider.product,
              builder: (_, product, __) =>
                  WishlistHeartButton(product: product),
            ),
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          spacing: 12,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.black.withValues(alpha: 0.1),
              child: ProductImageGallery(
                images: provider.product.productImageList,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            provider.product.productName,
                            style: textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.center,
                        width: 32,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "${provider.product.discount}%",
                          style: textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        provider.product.price.formatPrice(
                          provider.product.currency,
                          locale: locale,
                        ),
                        style: textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: CustomColors.customGrey,
                          decoration: TextDecoration.lineThrough,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: AppNetworkImage(
                            imageUrl:
                                provider.product.brandModel?.iconName ?? "",
                            errorIcon: Icons.store,
                            errorIconSize: 14,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            provider.product.brandModel?.brandName ?? "",
                            style: textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.check_circle,
                          color: Colors.blueAccent,
                          size: 14,
                        ),
                        const Spacer(),
                        Text(
                          provider.product.getPriceWithDiscount.formatPrice(
                            provider.product.currency,
                            locale: locale,
                          ),
                          style: textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        localization.productStock,
                        style: textTheme.bodyMedium,
                      ),
                      Text(
                        provider.product.stock > 0
                            ? localization.productInStock
                            : localization.productOutOfStock,
                        style: textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  ProductSizeSelector(
                    sizes: provider.product.productSize ?? const [],
                    onChanged: provider.setSelectedSize,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Consumer<ProductDetailsProvider>(
                      builder: (context, sizeProvider, _) => CustomButton(
                        buttonText: AppLocalizations.of(
                          context,
                        ).productAddToCart,
                        enable: sizeProvider.canAddToCart,
                        margin: EdgeInsets.zero,
                        onPress: () {
                          CartModel cartModel = CartModel(
                            productModel: provider.product,
                            size: sizeProvider.selectedSize ?? "",
                          );
                          provider.addToCart(cartModel);
                          SnackBarPopup.showMessage(
                            context,
                            message: AppLocalizations.of(
                              context,
                            ).productAddedToCart,
                            snackBarMessageType: SnackBarMessageType.success,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
