import 'package:flutter/material.dart';

import '/core/l10n/app_localizations.dart';
import '/core/styles/app_radius.dart';
import '/core/styles/app_spacing.dart';
import '/core/widgets/app_network_image.dart';

class ProductImageGallery extends StatefulWidget {
  const ProductImageGallery({required this.images, this.heroTag, super.key});

  final List<String> images;

  // Hero target for the first image; null when there is no source to fly from.
  final String? heroTag;

  @override
  State<ProductImageGallery> createState() => _ProductImageGalleryState();
}

class _ProductImageGalleryState extends State<ProductImageGallery> {
  late final PageController _pageController = PageController();
  int _selectedImage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.images;
    if (images.isEmpty) {
      return const SizedBox.shrink();
    }

    final colorScheme = Theme.of(context).colorScheme;
    final selectedImage = _selectedImage.clamp(0, images.length - 1);

    return Column(
      children: [
        Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 220,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: images.length,
                  onPageChanged: (index) =>
                      setState(() => _selectedImage = index),
                  itemBuilder: (_, index) {
                    Widget image = ClipRRect(
                      borderRadius: AppRadius.lgAll,
                      child: AppNetworkImage(
                        imageUrl: images[index],
                        width: double.infinity,
                        height: 220,
                        // Default fit is cover, same as the card (no
                        // distortion during the hero flight).
                        errorIconSize: 80,
                      ),
                    );
                    final heroTag = widget.heroTag;
                    if (index == 0 && heroTag != null) {
                      // Only the first image matches the card, so the hero
                      // flies only while the first page is shown.
                      image = HeroMode(
                        enabled: selectedImage == 0,
                        child: Hero(tag: heroTag, child: image),
                      );
                    }
                    return image;
                  },
                ),
              ),
              if (images.length > 1)
                Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.sm),
                  child: _GalleryDots(
                    count: images.length,
                    selected: selectedImage,
                  ),
                ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          height: 90,
          alignment: Alignment.centerLeft,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (context, index) => Container(
              width: 92,
              margin: EdgeInsets.only(left: index == 0 ? 0 : AppSpacing.md),
              decoration: BoxDecoration(
                borderRadius: AppRadius.lgAll,
                border: Border.all(
                  color: selectedImage == index
                      ? colorScheme.outline
                      : colorScheme.outlineVariant,
                ),
              ),
              child: InkWell(
                onTap: () => _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                ),
                borderRadius: AppRadius.lgAll,
                child: ClipRRect(
                  borderRadius: AppRadius.lgAll,
                  child: AppNetworkImage(
                    imageUrl: images[index],
                    fit: BoxFit.fill,
                    errorIconSize: 36,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _GalleryDots extends StatelessWidget {
  const _GalleryDots({required this.count, required this.selected});

  final int count;
  final int selected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Semantics(
      label: AppLocalizations.of(
        context,
      ).productImageIndicator(selected + 1, count),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < count; i++)
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
              width: i == selected ? 16 : 6,
              height: 6,
              decoration: BoxDecoration(
                borderRadius: AppRadius.pillAll,
                color: i == selected
                    ? colorScheme.primary
                    : colorScheme.outlineVariant,
              ),
            ),
        ],
      ),
    );
  }
}
