import 'package:flutter/material.dart';

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
  int _selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    final images = widget.images;
    if (images.isEmpty) {
      return const SizedBox.shrink();
    }

    final colorScheme = Theme.of(context).colorScheme;
    final selectedImage = _selectedImage.clamp(0, images.length - 1);

    Widget image = ClipRRect(
      borderRadius: AppRadius.lgAll,
      child: AppNetworkImage(
        imageUrl: images[selectedImage],
        height: 220,
        width: double.infinity,
        fit: BoxFit.fill,
        errorIconSize: 80,
      ),
    );
    final heroTag = widget.heroTag;
    if (heroTag != null) {
      // Only the first image matches the card, so other images never fly.
      image = HeroMode(
        enabled: selectedImage == 0,
        child: Hero(tag: heroTag, child: image),
      );
    }

    return Column(
      children: [
        Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          width: double.infinity,
          child: image,
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
                onTap: () => setState(() => _selectedImage = index),
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
