import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/main_provider.dart';
import '/utils/custom_navigator.dart';
import '/widgets/custom_app_bar.dart';
import '/widgets/custom_button.dart';
import '/widgets/main_layout.dart';
import 'checkout_providers/checkout_provider.dart';
import 'checkout_screen.dart';
import 'checkout_widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);

    return MainLayout(
      appBar: const CustomAppBar(titleText: "Cart"),
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.topCenter,
        children: [
          Consumer<MainProvider>(
            builder: (_, __, child) => ListView.builder(
              key: UniqueKey(),
              padding: const EdgeInsets.only(top: 8),
              shrinkWrap: true,
              itemCount: mainProvider.cartProducts.length,
              itemBuilder: (_, index) => CartItem(
                key: UniqueKey(),
                cartModel: mainProvider.cartProducts[index],
              ),
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
                child: Consumer<MainProvider>(
                  builder: (_, __, child) =>
                      mainProvider.cartProducts.isNotEmpty
                      ? CustomButton(
                          buttonText:
                              "Checkout ${mainProvider.checkoutPrice.toStringAsFixed(2)} ${mainProvider.cartProducts.first.productModel.currency}",
                          enable: mainProvider.cartProducts.isNotEmpty,
                          onPress: () =>
                              CustomNavigator(context).pushNavigation(
                                routeName: CheckoutScreen.routeName,
                                screen: ChangeNotifierProvider(
                                  create: (ctx) => CheckoutProvider(
                                    userRepository: ctx.read(),
                                    cartProducts: mainProvider.cartProducts,
                                    checkoutPrice: mainProvider.checkoutPrice,
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
