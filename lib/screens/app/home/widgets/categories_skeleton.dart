import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '/core/styles/app_spacing.dart';
import '/core/widgets/shimmer/shimmer.dart';
import '/core/widgets/shimmer/shimmer_box.dart';

/// Loading placeholder for the categories row on the primary header band.
class CategoriesSkeleton extends StatelessWidget {
  const CategoriesSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final base = Color.alphaBlend(
      scheme.onPrimary.withValues(alpha: 0.25),
      scheme.primary,
    );
    final highlight = Color.alphaBlend(
      scheme.onPrimary.withValues(alpha: 0.45),
      scheme.primary,
    );

    return Shimmer(
      baseColor: base,
      highlightColor: highlight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 7,
        itemBuilder: (_, _) => const _CategorySkeletonItem(),
      ),
    );
  }
}

class _CategorySkeletonItem extends StatelessWidget {
  const _CategorySkeletonItem();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 14),
      child: Column(
        children: [
          ShimmerBox(width: 48, height: 48, shape: BoxShape.circle),
          Gap(AppSpacing.xs),
          ShimmerBox(width: 40, height: 8),
        ],
      ),
    );
  }
}
