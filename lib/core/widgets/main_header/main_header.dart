import 'package:flutter/material.dart';

import '../../styles/custom_colors.dart';
import 'shopping_cart/shopping_cart.dart';

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
          if (showCartIcon) ShoppingCart(iconColor: contentColor),
        ],
      ),
    );
  }
}
