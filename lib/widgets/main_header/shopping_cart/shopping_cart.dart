import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/utils/constants/custom_colors.dart';
import '/screens/app/purchase/cart/cart_screen.dart';
import '/screens/app/purchase/cart/providers/cart_provider.dart';
import '/utils/custom_navigator.dart';
import 'providers/shopping_cart_provider.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({this.iconColor, super.key});
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ShoppingCartProvider(cartRepository: context.read()),
      child: _ShoppingCartView(iconColor: iconColor),
    );
  }
}

class _ShoppingCartView extends StatelessWidget {
  const _ShoppingCartView({this.iconColor});
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () => CustomNavigator(context).pushNavigation(
        routeName: CartScreen.routeName,
        screen: ChangeNotifierProvider(
          create: (ctx) => CartProvider(cartRepository: ctx.read()),
          child: const CartScreen(),
        ),
      ),
      child: SizedBox(
        height: 48,
        width: 44,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Icon(
              Icons.shopping_cart,
              color: iconColor ?? CustomColors.secondary,
              size: 28,
            ),
            Consumer<ShoppingCartProvider>(
              builder: (_, provider, __) => provider.productNumber > 0
                  ? Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        height: 18,
                        width: 18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(99),
                          color: Colors.black,
                        ),
                        child: Center(
                          child: Text(
                            provider.productNumber.toString(),
                            style: textTheme.labelLarge!.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
