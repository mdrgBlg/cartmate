import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '/utils/common_utils.dart';
import '/utils/constants/custom_colors.dart';
import '/utils/constants/custom_icons.dart';
import '/utils/extensions/date_time_extension.dart';
import '/widgets/custom_app_bar.dart';
import '/widgets/layouts/main_layout.dart';
import 'providers/my_orders_provider.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  static const routeName = '/myOrders';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => MyOrdersProvider(
        orderRepository: ctx.read(),
        userRepository: ctx.read(),
      ),
      child: const _MyOrdersScreen(),
    );
  }
}

class _MyOrdersScreen extends StatelessWidget {
  const _MyOrdersScreen();

  @override
  Widget build(BuildContext context) {
    final myOrdersProvider = Provider.of<MyOrdersProvider>(
      context,
      listen: false,
    );
    final textTheme = Theme.of(context).textTheme;
    return MainLayout(
      appBar: const CustomAppBar(titleText: "My Orders"),
      backgroundColor: Colors.white,
      child: FutureBuilder<void>(
        future: myOrdersProvider.myOrdersFuture,
        builder: (context, snapshot) =>
            snapshot.connectionState != ConnectionState.done
            ? const Center(child: CircularProgressIndicator())
            : snapshot.hasError || myOrdersProvider.hasError
            ? Center(
                child: Text(
                  // TODO(l10n): myOrdersError
                  "Something went wrong. Please try again",
                  style: textTheme.bodyMedium,
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(20),
                child: ListView.builder(
                  itemCount: myOrdersProvider.myOrders.length,
                  itemBuilder: (_, index) {
                    final orderStatus = getStatusOnIndex(
                      myOrdersProvider.myOrders[index].orderStatus,
                    );
                    return Container(
                      height: 120,
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: CustomColors.greyShade200.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: CustomColors.greyShade200),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.local_shipping_outlined),
                              const Gap(4),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (orderStatus != null)
                                    Text(
                                      orderStatus.name,
                                      style: textTheme.bodySmall!.copyWith(
                                        color: CustomColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  Text(
                                    DateTime.parse(
                                      myOrdersProvider
                                          .myOrders[index]
                                          .orderDate,
                                    ).formatDateTime(),
                                    style: textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              const Icon(Icons.arrow_forward_ios, size: 16),
                            ],
                          ),
                          const Gap(16),
                          Row(
                            children: [
                              Image.asset(
                                CustomIcons.priceTag,
                                height: 20,
                                width: 20,
                              ),
                              const Gap(8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Order",
                                    style: textTheme.bodySmall!.copyWith(
                                      color: CustomColors.grayDark.withValues(
                                        alpha: 0.8,
                                      ),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    myOrdersProvider.myOrders[index].orderId,
                                    style: textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Image.asset(
                                CustomIcons.timing,
                                height: 24,
                                width: 24,
                              ),
                              const Gap(8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Shipping Date",
                                    style: textTheme.bodySmall!.copyWith(
                                      color: CustomColors.grayDark.withValues(
                                        alpha: 0.8,
                                      ),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    myOrdersProvider
                                            .myOrders[index]
                                            .deliveryDate ??
                                        "Unknown",
                                    style: textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(28),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
