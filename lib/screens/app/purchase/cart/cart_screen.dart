import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/core/l10n/app_localizations.dart';
import '/core/styles/app_spacing.dart';
import '/core/widgets/custom_app_bar.dart';
import '/core/widgets/custom_button.dart';
import '/core/widgets/layouts/main_layout.dart';
import '/data/models/cart_model.dart';
import '/utils/custom_navigator.dart';
import '/utils/extensions/price_extension.dart';
import '../checkout/checkout_screen.dart';
import '../widgets/purchase_item/purchase_item.dart';
import 'providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => CartProvider(cartRepository: ctx.read()),
      child: const _CartScreen(),
    );
  }
}

class _CartScreen extends StatelessWidget {
  const _CartScreen();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return MainLayout(
      appBar: CustomAppBar(titleText: localization.cartTitle),
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.topCenter,
        children: [
          Selector<CartProvider, List<CartModel>>(
            selector: (_, provider) => provider.cartProducts,
            builder: (context, cartProducts, child) => ListView.builder(
              padding: const EdgeInsets.only(top: AppSpacing.sm),
              shrinkWrap: true,
              itemCount: cartProducts.length,
              itemBuilder: (_, index) =>
                  PurchaseItem(cartModel: cartProducts[index]),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 50,
              margin: const EdgeInsets.only(bottom: 10.0),
              child: Consumer<CartProvider>(
                builder: (_, _, child) => cartProvider.cartProducts.isNotEmpty
                    ? CustomButton(
                        buttonText: localization.checkoutButton(
                          cartProvider.checkoutPrice.formatPrice(
                            cartProvider.cartProducts.first.currency,
                            locale: Localizations.localeOf(context).toString(),
                          ),
                        ),
                        enable: cartProvider.cartProducts.isNotEmpty,
                        onPress: () => CustomNavigator(context).pushNavigation(
                          routeName: CheckoutScreen.routeName,
                          screen: CheckoutScreen(
                            currency: cartProvider.cartProducts.first.currency,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
