import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/core/l10n/app_localizations.dart';
import '/core/styles/app_radius.dart';
import '/core/styles/app_spacing.dart';
import '/core/widgets/custom_app_bar.dart';
import '/core/widgets/custom_button.dart';
import '/core/widgets/input_field.dart';
import '/core/widgets/layouts/main_layout.dart';
import '/utils/assets/custom_icons.dart';
import '/utils/extensions/price_extension.dart';
import '/utils/loading.dart';
import '/utils/snack_bar_popup.dart';
import '../widgets/purchase_item/purchase_item.dart';
import 'providers/checkout_provider.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({required this.currency, super.key});

  final String currency;

  static const routeName = '/checkout';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => CheckoutProvider(
        userRepository: ctx.read(),
        cartRepository: ctx.read(),
        orderRepository: ctx.read(),
      ),
      child: _CheckoutScreen(currency: currency),
    );
  }
}

class _CheckoutScreen extends StatelessWidget {
  const _CheckoutScreen({required this.currency});

  final String currency;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final checkoutProvider = Provider.of<CheckoutProvider>(
      context,
      listen: false,
    );
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final locale = Localizations.localeOf(context).toString();
    return MainLayout(
      appBar: CustomAppBar(titleText: localization.checkoutOrderReview),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              padding: const EdgeInsets.only(top: AppSpacing.sm),
              shrinkWrap: true,
              itemCount: checkoutProvider.cartProducts.length,
              itemBuilder: (_, index) => PurchaseItem(
                cartModel: checkoutProvider.cartProducts[index],
                isCartItem: false,
                height: 90,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  border: Border.all(color: colorScheme.outlineVariant),
                  borderRadius: AppRadius.lgAll,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          localization.checkoutSubtotal,
                          style: textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          checkoutProvider.checkoutPrice.formatPrice(
                            currency,
                            locale: locale,
                          ),
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
                          localization.checkoutShippingFee,
                          style: textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          checkoutProvider.shippingFee.formatPrice(
                            currency,
                            locale: locale,
                          ),
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
                          localization.checkoutOrderTotal,
                          style: textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          checkoutProvider.getTotalPrice().formatPrice(
                            currency,
                            locale: locale,
                          ),
                          style: textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Divider(thickness: 2),
                    const SizedBox(height: 20),
                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        localization.checkoutPaymentMethod,
                        style: textTheme.bodyLarge!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: AppSpacing.screenHorizontal,
                      ),
                      child: Row(
                        children: [
                          Image.asset(CustomIcons.cash),
                          const SizedBox(width: 16),
                          Text(
                            localization.checkoutCash,
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
                        localization.checkoutShippingData,
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
                            hintText: localization.checkoutFirstName,
                            controller: checkoutProvider.firstNameController,
                            onInputChanged: () =>
                                checkoutProvider.buttonChecker(),
                          ),
                        ),
                        Flexible(
                          child: InputField(
                            hintText: localization.checkoutLastName,
                            controller: checkoutProvider.lastNameController,
                            onInputChanged: () =>
                                checkoutProvider.buttonChecker(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    InputField(
                      hintText: localization.checkoutEmail,
                      controller: checkoutProvider.emailController,
                      onInputChanged: () => checkoutProvider.buttonChecker(),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Flexible(
                          child: InputField(
                            hintText: localization.checkoutCountry,
                            controller: checkoutProvider.countryController,
                            onInputChanged: () =>
                                checkoutProvider.buttonChecker(),
                            canRequestFocus: false,
                            onTap: () => showCountryPicker(
                              context: context,
                              useSafeArea: true,
                              countryListTheme: CountryListThemeData(
                                flagSize: 25,
                                backgroundColor: colorScheme.surface,
                                textStyle: textTheme.bodyLarge,
                                bottomSheetHeight: 500,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(AppRadius.xl),
                                ),
                                //Optional. Styles the search field.
                                inputDecoration: InputDecoration(
                                  labelText:
                                      localization.checkoutCountrySearchLabel,
                                  hintText:
                                      localization.checkoutCountrySearchHint,
                                  prefixIcon: const Icon(Icons.search),
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
                            hintText: localization.checkoutCity,
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
                            hintText: localization.checkoutZipCode,
                            controller: checkoutProvider.zipCodeController,
                            onInputChanged: () =>
                                checkoutProvider.buttonChecker(),
                          ),
                        ),
                        Flexible(
                          child: InputField(
                            hintText: localization.checkoutPhoneNumber,
                            controller: checkoutProvider.phoneNumberController,
                            onInputChanged: () =>
                                checkoutProvider.buttonChecker(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    InputField(
                      hintText: localization.checkoutAddress,
                      controller: checkoutProvider.addressController,
                      onInputChanged: () => checkoutProvider.buttonChecker(),
                    ),
                    const SizedBox(height: 24),
                    Consumer<CheckoutProvider>(
                      builder: (_, _, child) => SizedBox(
                        height: 50,
                        child: CustomButton(
                          margin: const EdgeInsets.only(
                            bottom: 10.0,
                            left: AppSpacing.screenHorizontal,
                            right: AppSpacing.screenHorizontal,
                          ),
                          buttonText: localization.checkoutButton(
                            checkoutProvider.getTotalPrice().formatPrice(
                              currency,
                              locale: locale,
                            ),
                          ),
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
    );
  }

  void onCheckoutTap(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final checkoutProvider = Provider.of<CheckoutProvider>(
      context,
      listen: false,
    );

    bool orderSaved = false;
    Loading.callLoading(
      context: context,
      callback: () async {
        orderSaved = await checkoutProvider.placeOrder();
      },
      onFinished: () {
        Navigator.of(
          context,
        ).popUntil((route) => route.settings.name == CheckoutScreen.routeName);
        if (orderSaved) {
          SnackBarPopup.showMessage(
            context,
            message: localization.checkoutOrderReceived,
            snackBarMessageType: SnackBarMessageType.success,
          );
        } else {
          SnackBarPopup.showMessage(
            context,
            message: localization.checkoutOrderSaveError,
            snackBarMessageType: SnackBarMessageType.error,
          );
        }
      },
    );
  }
}
