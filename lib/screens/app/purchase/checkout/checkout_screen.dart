import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/response_model.dart';
import '/utils/constants/custom_colors.dart';
import '/utils/constants/custom_icons.dart';
import '/utils/loading.dart';
import '/utils/snack_bar_popup.dart';
import '/widgets/custom_button.dart';
import '/widgets/input_field.dart';
import '../widgets/purchase_item/purchase_item.dart';
import 'providers/checkout_provider.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

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
                padding: const EdgeInsets.only(top: 8),
                shrinkWrap: true,
                itemCount: checkoutProvider.cartProducts.length,
                itemBuilder: (_, index) => PurchaseItem(
                  cartModel: checkoutProvider.cartProducts[index],
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
                    border: Border.all(color: CustomColors.customGrey),
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
                            "${checkoutProvider.checkoutPrice.toString()} ${checkoutProvider.cartProducts.first.currency}",
                            style: textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
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
                            "8.0 ${checkoutProvider.cartProducts.first.currency}",
                            style: textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
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
                            "${checkoutProvider.getTotalPrice().toString()} ${checkoutProvider.cartProducts.first.currency}",
                            style: textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Divider(
                        color: CustomColors.customGrey,
                        thickness: 2,
                      ),
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Image.asset(CustomIcons.cash),
                            const SizedBox(width: 16),
                            Text(
                              "Cash",
                              style: textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
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
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Flexible(
                            child: InputField(
                              hintText: "First name:",
                              controller: checkoutProvider.firstNameController,
                              onInputChanged: () =>
                                  checkoutProvider.buttonChecker(),
                            ),
                          ),
                          Flexible(
                            child: InputField(
                              hintText: "Last name:",
                              controller: checkoutProvider.lastNameController,
                              onInputChanged: () =>
                                  checkoutProvider.buttonChecker(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      InputField(
                        hintText: "E-mail:",
                        controller: checkoutProvider.emailController,
                        onInputChanged: () => checkoutProvider.buttonChecker(),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Flexible(
                            child: InputField(
                              hintText: "Country:",
                              controller: checkoutProvider.countryController,
                              onInputChanged: () =>
                                  checkoutProvider.buttonChecker(),
                              canRequestFocus: false,
                              onTap: () => showCountryPicker(
                                context: context,
                                useSafeArea: true,
                                countryListTheme: const CountryListThemeData(
                                  flagSize: 25,
                                  backgroundColor: Colors.white,
                                  textStyle: TextStyle(fontSize: 16),
                                  bottomSheetHeight: 500,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                  ),
                                  //Optional. Styles the search field.
                                  inputDecoration: InputDecoration(
                                    labelText: 'Search',
                                    hintText: 'Start typing to search',
                                    prefixIcon: Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: CustomColors.primary,
                                      ),
                                    ),
                                  ),
                                ),
                                onSelect: (value) {
                                  checkoutProvider.countryController.text =
                                      value.name;
                                  checkoutProvider.buttonChecker();
                                },
                              ),
                            ),
                          ),
                          Flexible(
                            child: InputField(
                              hintText: "City:",
                              controller: checkoutProvider.cityController,
                              onInputChanged: () =>
                                  checkoutProvider.buttonChecker(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Flexible(
                            child: InputField(
                              hintText: "Zip code:",
                              controller: checkoutProvider.zipCodeController,
                              onInputChanged: () =>
                                  checkoutProvider.buttonChecker(),
                            ),
                          ),
                          Flexible(
                            child: InputField(
                              hintText: "Phone number:",
                              controller:
                                  checkoutProvider.phoneNumberController,
                              onInputChanged: () =>
                                  checkoutProvider.buttonChecker(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      InputField(
                        hintText: "Address:",
                        controller: checkoutProvider.addressController,
                        onInputChanged: () => checkoutProvider.buttonChecker(),
                      ),
                      const SizedBox(height: 24),
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
                                "Checkout ${checkoutProvider.getTotalPrice()} ${checkoutProvider.cartProducts.first.currency}",
                            enable: checkoutProvider.isButtonEnabled,
                            onPress: () => onCheckoutTap(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onCheckoutTap(BuildContext context) {
    final checkoutProvider = Provider.of<CheckoutProvider>(
      context,
      listen: false,
    );

    ResponseModel? responseModel;
    Loading.callLoading(
      context: context,
      callback: () async {
        responseModel = await checkoutProvider.orderProduct();
      },
      onFinished: () {
        Navigator.of(
          context,
        ).popUntil((route) => route.settings.name == routeName);
        if (responseModel != null && responseModel!.success) {
          checkoutProvider.clearCart();
          SnackBarPopup.showMessage(
            context,
            message: "Your order has been received!",
            snackBarMessageType: SnackBarMessageType.success,
          );
        } else {
          SnackBarPopup.showMessage(
            context,
            message: responseModel?.error ?? "Something went wrong.",
            snackBarMessageType: SnackBarMessageType.error,
          );
        }
      },
    );
  }
}
