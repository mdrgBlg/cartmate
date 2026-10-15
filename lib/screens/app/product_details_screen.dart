import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/constants/custom_colors.dart';
import '/models/cart_model.dart';
import '/providers/main_provider.dart';
import '/providers/product_details_provider.dart';
import '/utils/snack_bar_popup.dart';
import '/widgets/app_network_image.dart';
import '/widgets/custom_button.dart';
import 'home/home_models/products_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({required this.product, super.key});
  final ProductsModel product;

  static const routeName = '/details';

  @override
  Widget build(BuildContext context) {
    final productDetailsProvider = Provider.of<ProductDetailsProvider>(
      context,
      listen: false,
    );
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black.withValues(alpha: 0.1),
          elevation: 0,
          foregroundColor: Colors.black,
          title: Row(
            children: [
              const Spacer(),
              InkWell(
                onTap: () async {
                  mainProvider.wishlistFlagChange(product);
                  if (product.whishlist) {
                    await mainProvider.addProductToWhishlist(product);
                  } else {
                    await mainProvider.removeProductFromWhishlist(product);
                  }
                },
                borderRadius: BorderRadius.circular(99),
                child: Consumer<MainProvider>(
                  builder: (_, __, child) => Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(99),
                      color: Colors.grey.withValues(alpha: 0.2),
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: product.whishlist ? Colors.red : Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(height: 348, color: Colors.black.withValues(alpha: 0.1)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Consumer<ProductDetailsProvider>(
                      builder: (_, __, child) => Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: AppNetworkImage(
                            imageUrl:
                                product.productImageList[productDetailsProvider
                                    .selectedImage],
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.fill,
                            errorIconSize: 80,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      height: 90,
                      alignment: Alignment.centerLeft,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: product.productImageList.length,
                        itemBuilder: (context, index) =>
                            Consumer<ProductDetailsProvider>(
                              builder: (_, __, child) => Container(
                                width: 92,
                                margin: EdgeInsets.only(
                                  left: index == 0 ? 0 : 12,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color:
                                        productDetailsProvider.selectedImage ==
                                            index
                                        ? Colors.black.withValues(alpha: 0.5)
                                        : Colors.black.withValues(alpha: 0.1),
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () => productDetailsProvider
                                      .changeSelectedImage(index),
                                  borderRadius: BorderRadius.circular(16),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: AppNetworkImage(
                                      imageUrl: product.productImageList[index],
                                      fit: BoxFit.fill,
                                      errorIconSize: 36,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              product.productName,
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
                            "${product.discount}%",
                            style: textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "${product.price.toDouble().toString()} ${product.currency}",
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
                              imageUrl: product.brandModel?.iconName ?? "",
                              errorIcon: Icons.store,
                              errorIconSize: 14,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              product.brandModel?.brandName ?? "",
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
                            "${(product.price - product.price * (product.discount / 100))} ${product.currency}",
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
                          product.stock > 0 ? "In stock" : "Out of stock",
                          style: textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    if (product.productSize?.isNotEmpty ?? false)
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "Size",
                          style: textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        spacing: 10, // spacing between adjacent containers
                        runSpacing: 8, // spacing between rows
                        children: List.generate(
                          product.productSize?.length ?? 0,
                          (index) {
                            return Consumer<ProductDetailsProvider>(
                              builder: (_, __, child) => InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () =>
                                    productDetailsProvider.changeSelectedSize(
                                      product.productSize?[index] ?? "",
                                    ),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 64,
                                  height:
                                      40, // adjust the height as per your need
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color:
                                          productDetailsProvider.selectedSize ==
                                              product.productSize?[index]
                                          ? Colors.black.withValues(alpha: 0.2)
                                          : Colors.black,
                                      width: 1,
                                    ),
                                    color:
                                        productDetailsProvider.selectedSize ==
                                            product.productSize?[index]
                                        ? CustomColors.primary
                                        : CustomColors.secondary,
                                  ),
                                  child: Text(
                                    product.productSize?[index] ?? "",
                                    style: textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          productDetailsProvider.selectedSize ==
                                              product.productSize?[index]
                                          ? CustomColors.secondary
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Consumer<ProductDetailsProvider>(
                        builder: (_, __, child) => CustomButton(
                          buttonText: "Add to cart",
                          enable:
                              productDetailsProvider.selectedSize != null ||
                              product.productSize == null,
                          margin: EdgeInsets.zero,
                          onPress: () {
                            ProductsModel copiedProduct = ProductsModel.copy(
                              product,
                            );
                            CartModel cartModel = CartModel(
                              productModel: copiedProduct,
                              size: productDetailsProvider.selectedSize ?? "",
                            );
                            mainProvider.addProductToCart(cartModel);
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
            ),
          ],
        ),
      ),
    );
  }
}
