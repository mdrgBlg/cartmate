import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '/core/styles/app_radius.dart';
import '/core/styles/app_spacing.dart';
import '/core/widgets/shimmer/shimmer.dart';
import '/core/widgets/shimmer/shimmer_box.dart';

class ProductsGridSkeleton extends StatelessWidget {
  const ProductsGridSkeleton({this.itemCount = 4, super.key});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontal,
          vertical: 6,
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppSpacing.sm,
            mainAxisSpacing: AppSpacing.sm,
            mainAxisExtent: 263,
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: itemCount,
          itemBuilder: (_, _) => const _ProductSkeletonCard(),
        ),
      ),
    );
  }
}

class _ProductSkeletonCard extends StatelessWidget {
  const _ProductSkeletonCard();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerBox(height: 140, borderRadius: AppRadius.lgAll),
          Gap(AppSpacing.md),
          ShimmerBox(height: 12, width: 110),
          Gap(AppSpacing.sm),
          ShimmerBox(height: 10, width: 70),
          Spacer(),
          ShimmerBox(height: 14, width: 60),
        ],
      ),
    );
  }
}
