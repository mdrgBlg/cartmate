import 'package:e_commerce/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/main_provider.dart';
import '/constants/custom_colors.dart';
import 'cart_widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mainProvider = Provider.of<MainProvider>(
      context,
      listen: false,
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 52,
          backgroundColor: CustomColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Cart",
            style: textTheme.titleLarge!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          alignment: Alignment.topCenter,
          children: [
            Consumer<MainProvider>(
              builder: (_, __, child) => ListView.builder(
                padding: const EdgeInsets.only(top: 8),
                shrinkWrap: true,
                itemCount: mainProvider.cartProducts.length,
                itemBuilder: (context, index) => CartItem(
                  product: mainProvider.cartProducts[index],
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
                                    "Checkout ${mainProvider.checkoutPrice}",
                                enable: mainProvider.cartProducts.isNotEmpty,
                                onPress: () {},
                              )
                            : const SizedBox(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
