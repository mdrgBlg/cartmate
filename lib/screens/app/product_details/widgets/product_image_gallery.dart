import 'package:flutter/material.dart';

import '/core/widgets/app_network_image.dart';

class ProductImageGallery extends StatefulWidget {
  const ProductImageGallery({required this.images, super.key});

  final List<String> images;

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

    final selectedImage = _selectedImage.clamp(0, images.length - 1);

    return Column(
      children: [
        Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 8),
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AppNetworkImage(
              imageUrl: images[selectedImage],
              height: 220,
              width: double.infinity,
              fit: BoxFit.fill,
              errorIconSize: 80,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          height: 90,
          alignment: Alignment.centerLeft,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (context, index) => Container(
              width: 92,
              margin: EdgeInsets.only(left: index == 0 ? 0 : 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: selectedImage == index
                      ? Colors.black.withValues(alpha: 0.5)
                      : Colors.black.withValues(alpha: 0.1),
                ),
              ),
              child: InkWell(
                onTap: () => setState(() => _selectedImage = index),
                borderRadius: BorderRadius.circular(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
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
