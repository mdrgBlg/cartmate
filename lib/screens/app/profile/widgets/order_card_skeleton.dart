import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '/core/styles/app_spacing.dart';
import '/core/widgets/shimmer/shimmer.dart';
import '/core/widgets/shimmer/shimmer_box.dart';

class OrderCardSkeleton extends StatelessWidget {
  const OrderCardSkeleton({this.itemCount = 4, super.key});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: (_, _) => const _OrderSkeletonCard(),
      ),
    );
  }
}

class _OrderSkeletonCard extends StatelessWidget {
  const _OrderSkeletonCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.only(bottom: AppSpacing.lg),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: const Column(
        children: [
          Row(
            children: [
              ShimmerBox(width: 24, height: 24, shape: BoxShape.circle),
              Gap(8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(width: 60, height: 10),
                  Gap(AppSpacing.xs),
                  ShimmerBox(width: 120, height: 14),
                ],
              ),
            ],
          ),
          Gap(16),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(width: 70, height: 10),
                  Gap(AppSpacing.xs),
                  ShimmerBox(width: 90, height: 14),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(width: 70, height: 10),
                  Gap(AppSpacing.xs),
                  ShimmerBox(width: 90, height: 14),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
