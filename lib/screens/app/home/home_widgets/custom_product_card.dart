import 'package:flutter/material.dart';

import '/constants/custom_colors.dart';
import '/constants/custom_images.dart';

class CustomProductCard extends StatelessWidget {
  const CustomProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: CustomColors.grayDark.withOpacity(0.2),
              blurRadius: 50,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      CustomImages.shoesGrid,
                      height: 140,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                  constraints: BoxConstraints(),
                  child: Text(
                    "Green Nike sports shoes adassda",
                    style: textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
                  child: Row(
                    children: [
                      Text(
                        "Nike",
                        style: textTheme.bodySmall!.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const Icon(
                        Icons.check_circle,
                        color: CustomColors.primary,
                        size: 14,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "30.0 KM",
                        style: textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                        padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                        child: Text(
                          "+",
                          style: textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              left: 8,
              top: 8,
              child: Container(
                alignment: AlignmentDirectional.center,
                width: 36,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "78%",
                  style: textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 4,
              top: 4,
              child: Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(99),
                  color: Colors.grey.withOpacity(0.2),
                ),
                child: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
