import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '/core/l10n/app_localizations.dart';
import '/core/styles/app_spacing.dart';
import '/core/widgets/custom_app_bar.dart';
import '/core/widgets/layouts/main_layout.dart';
import '/data/models/brand_model.dart';
import 'widgets/brand_grid.dart';

class ViewAllBrandsScreen extends StatelessWidget {
  const ViewAllBrandsScreen({required this.brandsList, super.key});
  final List<BrandModel> brandsList;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return MainLayout(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      appBar: CustomAppBar(
        titleText: localization.storeBrand,
        type: AppBarType.dark,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(16),
          Padding(
            padding: const EdgeInsets.only(
              left: AppSpacing.screenHorizontal,
              bottom: AppSpacing.sm,
            ),
            child: Text(
              localization.storeBrands,
              style: textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          brandsList.isNotEmpty
              ? BrandGrid(brandList: brandsList, showLimited: false)
              : Container(),
        ],
      ),
    );
  }
}
