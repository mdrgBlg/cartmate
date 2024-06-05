import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/custom_button.dart';
import '/constants/custom_colors.dart';
import '/constants/custom_icons.dart';
import '/models/cart_model.dart';
import '/widgets/input_field.dart';
import 'cart_providers/checkout_provider.dart';
import 'cart_widgets/cart_item.dart';

class CheckoutScreen extends StatelessWidget {
  final List<CartModel> cartProducts;
  final double checkoutPrice;
  const CheckoutScreen({
    super.key,
    required this.cartProducts,
    required this.checkoutPrice,
  });

  static const routeName = '/checkout';

  @override
  Widget build(BuildContext context) {
    final checkoutProvider = Provider.of<CheckoutProvider>(
      context,
      listen: false,
    );
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 52,
          backgroundColor: CustomColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Order review",
            style: textTheme.titleLarge!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                key: UniqueKey(),
                padding: const EdgeInsets.only(top: 8),
                shrinkWrap: true,
                itemCount: cartProducts.length,
                itemBuilder: (_, index) => CartItem(
                  key: UniqueKey(),
                  cartModel: cartProducts[index],
                  isCartItem: false,
                  height: 90,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: CustomColors.customGrey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Subtotal",
                            style: textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${checkoutPrice.toString()} ${cartProducts.first.productModel.currency}",
                            style: textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Shipping fee",
                            style: textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "8.0 ${cartProducts.first.productModel.currency}",
                            style: textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Order total",
                            style: textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${(checkoutPrice + 8).toString()} ${cartProducts.first.productModel.currency}",
                            style: textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Divider(
                        color: CustomColors.customGrey,
                        thickness: 2,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          "Payment method",
                          style: textTheme.bodyLarge!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Image.asset(
                              CustomIcons.cash,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(
                              "Cash",
                              style: textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Container(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          "Shipping data",
                          style: textTheme.bodyLarge!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: InputField(
                              hintText: "First name:",
                              controller: checkoutProvider.firstNameController,
                            ),
                          ),
                          Flexible(
                            child: InputField(
                              hintText: "Last name:",
                              controller: checkoutProvider.lastNameController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      InputField(
                        hintText: "E-mail:",
                        controller: checkoutProvider.eMailController,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: InputField(
                              hintText: "Country:",
                              controller: checkoutProvider.countryController,
                            ),
                          ),
                          Flexible(
                            child: InputField(
                              hintText: "City:",
                              controller: checkoutProvider.cityController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: InputField(
                              hintText: "Zip code:",
                              controller: checkoutProvider.zipCodeController,
                            ),
                          ),
                          Flexible(
                            child: InputField(
                              hintText: "Phone number:",
                              controller:
                                  checkoutProvider.phoneNumberController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      InputField(
                        hintText: "Address:",
                        controller: checkoutProvider.eMailController,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Consumer<CheckoutProvider>(
                        builder: (_, __, child) => SizedBox(
                          height: 50,
                          child: CustomButton(
                            margin: const EdgeInsets.only(
                              bottom: 10.0,
                              left: 20,
                              right: 20,
                            ),
                            buttonText:
                                "Checkout ${(8 + checkoutPrice)} ${cartProducts.first.productModel.currency}",
                            enable: checkoutProvider.isButtonEnabled,
                            onPress: () => {},
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
