import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '/core/styles/app_radius.dart';
import '/core/styles/app_spacing.dart';
import '/core/widgets/shimmer/shimmer.dart';
import '/core/widgets/shimmer/shimmer_box.dart';

class CategoriesBrandsSkeleton extends StatelessWidget {
  const CategoriesBrandsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Shimmer(
      child: Column(children: [_Card(), Gap(AppSpacing.lg), _Card()]),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppSpacing.xl),
      child: Column(
        children: [
          Row(
            children: [
              ShimmerBox(width: 36, height: 36),
              Gap(12),
              ShimmerBox(width: 90, height: 12),
            ],
          ),
          Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShimmerBox(width: 80, height: 80, borderRadius: AppRadius.lgAll),
              Gap(AppSpacing.sm),
              ShimmerBox(width: 80, height: 80, borderRadius: AppRadius.lgAll),
              Gap(AppSpacing.sm),
              ShimmerBox(width: 80, height: 80, borderRadius: AppRadius.lgAll),
            ],
          ),
        ],
      ),
    );
  }
}
