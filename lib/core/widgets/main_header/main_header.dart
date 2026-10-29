import 'package:flutter/material.dart';

import '../../styles/app_spacing.dart';
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
      padding: const EdgeInsets.only(
        left: AppSpacing.screenHorizontal,
        right: AppSpacing.lg,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: AppSpacing.xs),
            child: Text(
              text,
              style: textTheme.titleLarge!.copyWith(
                color: contentColor ?? Theme.of(context).colorScheme.onPrimary,
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
