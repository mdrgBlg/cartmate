import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '/core/l10n/app_localizations.dart';
import '/core/styles/app_radius.dart';
import '/core/styles/app_spacing.dart';
import '/core/widgets/custom_app_bar.dart';
import '/core/widgets/empty_state.dart';
import '/core/widgets/error_view.dart';
import '/core/widgets/layouts/main_layout.dart';
import '/screens/app/home/home_screen.dart';
import '/utils/assets/custom_icons.dart';
import '/utils/assets/custom_illustrations.dart';
import '/utils/common_utils.dart';
import '/utils/custom_navigator.dart';
import '/utils/extensions/date_time_extension.dart';
import 'providers/my_orders_provider.dart';
import 'widgets/order_card_skeleton.dart';

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
    final localization = AppLocalizations.of(context);
    final myOrdersProvider = Provider.of<MyOrdersProvider>(
      context,
      listen: false,
    );
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return MainLayout(
      appBar: CustomAppBar(titleText: localization.myOrdersTitle),
      backgroundColor: colorScheme.surfaceContainerLowest,
      child: Selector<MyOrdersProvider, Future<void>>(
        selector: (_, provider) => provider.myOrdersFuture,
        builder: (_, future, _) => FutureBuilder<void>(
          future: future,
          builder: (context, snapshot) =>
              snapshot.connectionState != ConnectionState.done
              ? const Padding(
                  padding: EdgeInsets.all(AppSpacing.xl),
                  child: OrderCardSkeleton(),
                )
              : snapshot.hasError || myOrdersProvider.hasError
              ? ErrorView(onRetry: myOrdersProvider.reload)
              : myOrdersProvider.myOrders.isEmpty
              ? EmptyState(
                  illustration: CustomIllustrations.emptyOrders,
                  title: localization.myOrdersEmptyTitle,
                  message: localization.myOrdersEmptyMessage,
                  actionLabel: localization.startShopping,
                  onAction: () => CustomNavigator(context).pushReplacement(
                    routeName: HomeScreen.routeName,
                    screen: const HomeScreen(),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: ListView.builder(
                    itemCount: myOrdersProvider.myOrders.length,
                    itemBuilder: (_, index) {
                      final orderStatus = getStatusOnIndex(
                        myOrdersProvider.myOrders[index].orderStatus,
                      );
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        margin: const EdgeInsets.only(bottom: AppSpacing.lg),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainer,
                          borderRadius: AppRadius.lgAll,
                          border: Border.all(color: colorScheme.outlineVariant),
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
                                        orderStatus.statusName(localization),
                                        style: textTheme.bodySmall!.copyWith(
                                          color: colorScheme.primary,
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
                              spacing: 8,
                              children: [
                                Flexible(
                                  child: _OrderInfo(
                                    icon: CustomIcons.priceTag,
                                    label: localization.myOrdersOrder,
                                    value: myOrdersProvider
                                        .myOrders[index]
                                        .orderId,
                                  ),
                                ),
                                _OrderInfo(
                                  icon: CustomIcons.timing,
                                  iconSize: 24,
                                  label: localization.myOrdersShippingDate,
                                  value:
                                      myOrdersProvider
                                          .myOrders[index]
                                          .deliveryDate ??
                                      localization.myOrdersUnknown,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}

class _OrderInfo extends StatelessWidget {
  const _OrderInfo({
    required this.icon,
    required this.label,
    required this.value,
    this.iconSize = 20,
  });

  final String icon;
  final String label;
  final String value;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          icon,
          color: colorScheme.onSurface,
          height: iconSize,
          width: iconSize,
        ),
        const Gap(8),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: textTheme.bodySmall!.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
              Text(
                value,
                style: textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
