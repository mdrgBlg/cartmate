import 'package:e_commerce/models/brand_model.dart';
import 'package:flutter/material.dart';

import '/constants/custom_colors.dart';
import '/widgets/app_network_image.dart';

class BrandContainer extends StatelessWidget {
  final BrandModel brand;
  const BrandContainer({
    super.key,
    required this.brand,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.only(
        left: 16,
        top: 12,
        bottom: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: CustomColors.text.withOpacity(0.4),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 36,
            width: 36,
            child: AppNetworkImage(
              imageUrl: brand.iconName,
              fit: BoxFit.cover,
              errorIcon: Icons.store,
              errorIconSize: 20,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      brand.brandName,
                      style: textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Icon(
                      Icons.check_circle,
                      color: Colors.blueAccent,
                      size: 14,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      brand.productCount.toString(),
                      style: textTheme.bodySmall!.copyWith(
                        color: CustomColors.text.withOpacity(0.4),
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      "products",
                      style: textTheme.bodySmall!.copyWith(
                        color: CustomColors.text.withOpacity(0.4),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
