import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    required this.imageUrl,
    super.key,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.errorIcon = Icons.image_not_supported,
    this.errorIconSize = 32,
  });

  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit fit;
  final IconData errorIcon;
  final double errorIconSize;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: height,
      width: width,
      fit: fit,
      placeholder: (context, url) => Container(
        height: height ?? double.infinity,
        width: width ?? double.infinity,
        color: Colors.grey[200],
      ),
      errorWidget: (context, url, error) => Container(
        height: height ?? double.infinity,
        width: width ?? double.infinity,
        color: Colors.grey[200],
        child: Icon(errorIcon, color: Colors.grey, size: errorIconSize),
      ),
    );
  }
}
