import 'package:flutter/material.dart';

import '/constants/custom_colors.dart';
import '/constants/custom_images.dart';
import '/models/brand_model.dart';

class BrandGrid extends StatelessWidget {
  final List<BrandModel> brandList;
  const BrandGrid({
    super.key,
    required this.brandList,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          mainAxisExtent: 60,
        ),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: brandList.length > 6 ? 6 : brandList.length,
        itemBuilder: (context, index) => brandList.isNotEmpty
            ? Container(
                padding: const EdgeInsets.only(
                  left: 16,
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
                      child: Image.asset(CustomImages.nikeLogo),
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
                                brandList[index].brandName,
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
                                brandList[index].productCount.toString(),
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
              )
            : null,
      ),
    );
  }
}
