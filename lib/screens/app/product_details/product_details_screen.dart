import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/constants/custom_colors.dart';
import '/models/cart_model.dart';
import '/models/products_model.dart';
import '/providers/product_details_provider.dart';
import '/utils/snack_bar_popup.dart';
import '/widgets/app_network_image.dart';
import '/widgets/custom_app_bar.dart';
import '/widgets/custom_button.dart';
import '/widgets/layouts/main_layout.dart';
import '/widgets/wishlist_heart_button.dart';
import 'widgets/product_image_gallery.dart';
import 'widgets/product_size_selector.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  static const routeName = '/details';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductDetailsProvider>(
      context,
      listen: false,
    );
    final textTheme = Theme.of(context).textTheme;

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
                        provider.product.getPriceWithCurrency,
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
                          provider.product.getPriceWithDiscountAndCurrency,
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
                      Text('Stock: ', style: textTheme.bodyMedium),
                      Text(
                        provider.product.stock > 0
                            ? "In stock"
                            : "Out of stock",
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
                        buttonText: "Add to cart",
                        enable:
                            sizeProvider.selectedSize != null ||
                            provider.product.productSize == null,
                        margin: EdgeInsets.zero,
                        onPress: () {
                          CartModel cartModel = CartModel(
                            productModel: ProductsModel.copy(provider.product),
                            size: sizeProvider.selectedSize ?? "",
                          );
                          provider.addToCart(cartModel);
                          SnackBarPopup.showMessage(
                            context,
                            message: "Product is added to cart",
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
