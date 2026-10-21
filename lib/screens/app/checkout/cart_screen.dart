import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/cart_model.dart';
import '/utils/custom_navigator.dart';
import '/widgets/custom_app_bar.dart';
import '/widgets/custom_button.dart';
import '/widgets/main_layout.dart';
import 'checkout_providers/cart_provider.dart';
import 'checkout_providers/checkout_provider.dart';
import 'checkout_screen.dart';
import 'checkout_widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return MainLayout(
      appBar: const CustomAppBar(titleText: "Cart"),
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.topCenter,
        children: [
          Selector<CartProvider, List<CartModel>>(
            selector: (_, provider) => provider.cartProducts,
            builder: (context, cartProducts, child) => ListView.builder(
              padding: const EdgeInsets.only(top: 8),
              shrinkWrap: true,
              itemCount: cartProducts.length,
              itemBuilder: (_, index) =>
                  CartItem(cartModel: cartProducts[index]),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 50,
              child: Container(
                margin: const EdgeInsets.only(bottom: 10.0),
                child: Consumer<CartProvider>(
                  builder: (_, __, child) =>
                      cartProvider.cartProducts.isNotEmpty
                      ? CustomButton(
                          buttonText:
                              "Checkout ${cartProvider.checkoutPrice.toStringAsFixed(2)} ${cartProvider.cartProducts.first.productModel.currency}",
                          enable: cartProvider.cartProducts.isNotEmpty,
                          onPress: () =>
                              CustomNavigator(context).pushNavigation(
                                routeName: CheckoutScreen.routeName,
                                screen: ChangeNotifierProvider(
                                  create: (ctx) => CheckoutProvider(
                                    userRepository: ctx.read(),
                                    cartRepository: ctx.read(),
                                    cartProducts: cartProvider.cartProducts,
                                    checkoutPrice: cartProvider.checkoutPrice,
                                  ),
                                  child: const CheckoutScreen(),
                                ),
                              ),
                        )
                      : const SizedBox(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
