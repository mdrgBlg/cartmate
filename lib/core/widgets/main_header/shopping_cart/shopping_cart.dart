import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../styles/app_radius.dart';
import '/screens/app/purchase/cart/cart_screen.dart';
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
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () => CustomNavigator(context).pushNavigation(
        routeName: CartScreen.routeName,
        screen: const CartScreen(),
      ),
      child: SizedBox(
        height: 48,
        width: 44,
        child: Stack(
          // The bump overshoot must not be clipped by the box.
          clipBehavior: Clip.none,
          alignment: Alignment.centerLeft,
          children: [
            Icon(
              Icons.shopping_cart,
              color: iconColor ?? colorScheme.onPrimary,
              size: 28,
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Consumer<ShoppingCartProvider>(
                builder: (context, provider, _) {
                  final count = provider.productNumber;
                  // AnimatedSwitcher never animates its initial child, so
                  // only later count changes bump.
                  return AnimatedSwitcher(
                    duration: MediaQuery.disableAnimationsOf(context)
                        ? Duration.zero
                        : const Duration(milliseconds: 250),
                    switchInCurve: Curves.easeOutBack,
                    switchOutCurve: Curves.easeIn,
                    transitionBuilder: (child, animation) =>
                        ScaleTransition(scale: animation, child: child),
                    child: count > 0
                        ? _CartBadge(key: ValueKey(count), count: count)
                        : const SizedBox.shrink(key: ValueKey(0)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartBadge extends StatelessWidget {
  const _CartBadge({required this.count, super.key});

  final int count;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: 18,
      width: 18,
      decoration: BoxDecoration(
        borderRadius: AppRadius.pillAll,
        color: colorScheme.inverseSurface,
      ),
      child: Center(
        child: Text(
          count.toString(),
          style: textTheme.labelLarge!.copyWith(
            color: colorScheme.onInverseSurface,
          ),
        ),
      ),
    );
  }
}
