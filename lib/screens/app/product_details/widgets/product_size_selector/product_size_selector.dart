import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/core/l10n/app_localizations.dart';
import '/core/styles/app_radius.dart';
import '/core/styles/app_spacing.dart';
import 'providers/product_size_provider.dart';

class ProductSizeSelector extends StatelessWidget {
  const ProductSizeSelector({required this.sizes, this.onChanged, super.key});

  final List<String> sizes;
  final ValueChanged<String?>? onChanged;

  @override
  Widget build(BuildContext context) {
    if (sizes.isEmpty) {
      return const SizedBox.shrink();
    }

    return ChangeNotifierProvider(
      create: (_) => ProductSizeProvider(onChanged: onChanged),
      child: _SizeView(sizes: sizes),
    );
  }
}

class _SizeView extends StatelessWidget {
  const _SizeView({required this.sizes});

  final List<String> sizes;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Text(
              localization.productSize,
              style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: [for (final size in sizes) _SizeItem(size: size)],
          ),
        ],
      ),
    );
  }
}

class _SizeItem extends StatelessWidget {
  const _SizeItem({required this.size});

  final String size;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = context.select<ProductSizeProvider, bool>(
      (provider) => provider.selectedSize == size,
    );

    return InkWell(
      borderRadius: AppRadius.smAll,
      onTap: () => context.read<ProductSizeProvider>().changeSelectedSize(size),
      child: Container(
        alignment: Alignment.center,
        width: 64,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: AppRadius.smAll,
          border: Border.all(
            color: isSelected ? colorScheme.primary : colorScheme.outline,
          ),
          color: isSelected ? colorScheme.primary : colorScheme.surface,
        ),
        child: Text(
          size,
          style: textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
