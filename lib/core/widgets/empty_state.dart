import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '/core/styles/app_spacing.dart';
import 'app_illustration.dart';

/// Illustration, title, message and an optional action for empty lists.
class EmptyState extends StatelessWidget {
  const EmptyState({
    required this.illustration,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
    super.key,
  }) : assert((actionLabel == null) == (onAction == null));

  /// Asset path from `CustomIllustrations`.
  final String illustration;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIllustration(asset: illustration),
              const Gap(AppSpacing.lg),
              Text(
                title,
                textAlign: TextAlign.center,
                style: textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(AppSpacing.sm),
              Text(
                message,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium!.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              if (actionLabel != null) ...[
                const Gap(AppSpacing.xxl),
                FilledButton(onPressed: onAction, child: Text(actionLabel!)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
