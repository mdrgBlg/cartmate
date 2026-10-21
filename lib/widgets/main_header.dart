import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/custom_colors.dart';
import '../providers/main_provider.dart';
import '../screens/app/checkout/cart_screen.dart';
import '../utils/custom_navigator.dart';
import 'shopping_cart.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({
    required this.text,
    this.showCartIcon = true,
    this.contentColor,
    super.key,
  });
  final String text;
  final bool showCartIcon;
  final Color? contentColor;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              text,
              style: textTheme.titleLarge!.copyWith(
                color: contentColor ?? CustomColors.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (showCartIcon)
            InkWell(
              onTap: () => CustomNavigator(context).pushNavigation(
                routeName: CartScreen.routeName,
                screen: const CartScreen(),
              ),
              child: Consumer<MainProvider>(
                builder: (_, mainProvider, child) => ShoppingCart(
                  productNumber: mainProvider.cartProductNumber,
                  iconColor: contentColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
