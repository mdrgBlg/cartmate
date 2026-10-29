import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '/core/styles/app_spacing.dart';
import '/core/widgets/shimmer/shimmer.dart';
import '/core/widgets/shimmer/shimmer_box.dart';

class BrandGridSkeleton extends StatelessWidget {
  const BrandGridSkeleton({this.itemCount = 6, super.key});

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
            crossAxisSpacing: AppSpacing.md,
            mainAxisSpacing: AppSpacing.md,
            mainAxisExtent: 60,
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: itemCount,
          itemBuilder: (_, _) => const _BrandTileSkeleton(),
        ),
      ),
    );
  }
}

class _BrandTileSkeleton extends StatelessWidget {
  const _BrandTileSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: AppSpacing.md),
      child: Row(
        children: [
          ShimmerBox(width: 36, height: 36),
          Gap(AppSpacing.md),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerBox(width: 70, height: 12),
              Gap(AppSpacing.xs),
              ShimmerBox(width: 48, height: 10),
            ],
          ),
        ],
      ),
    );
  }
}
