import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '/core/l10n/app_localizations.dart';
import '/core/styles/app_spacing.dart';
import '/utils/assets/custom_illustrations.dart';
import 'app_illustration.dart';

/// Localized error message with a retry button; never shows the exception.
///
/// [compact] renders a single row for narrow strips; the caller supplies
/// horizontal padding.
class ErrorView extends StatelessWidget {
  const ErrorView({
    required this.onRetry,
    this.compact = false,
    this.foregroundColor,
    super.key,
  });

  final VoidCallback onRetry;
  final bool compact;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    if (compact) {
      return Row(
        children: [
          Expanded(
            child: Text(
              localization.errorViewTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium!.copyWith(
                color: foregroundColor ?? colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          TextButton(
            onPressed: onRetry,
            style: TextButton.styleFrom(foregroundColor: foregroundColor),
            child: Text(localization.retry),
          ),
        ],
      );
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AppIllustration(asset: CustomIllustrations.error),
              const Gap(AppSpacing.lg),
              Text(
                localization.errorViewTitle,
                textAlign: TextAlign.center,
                style: textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(AppSpacing.sm),
              Text(
                localization.errorViewMessage,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium!.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const Gap(AppSpacing.xxl),
              FilledButton(onPressed: onRetry, child: Text(localization.retry)),
            ],
          ),
        ),
      ),
    );
  }
}
