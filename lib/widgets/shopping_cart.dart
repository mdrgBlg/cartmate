import 'package:flutter/material.dart';

import '/constants/custom_colors.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({required this.productNumber, this.iconColor, super.key});
  final int productNumber;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
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
          if (productNumber > 0)
            Positioned(
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
                    productNumber.toString(),
                    style: textTheme.labelLarge!.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
