import 'package:flutter/material.dart';

import '/core/styles/app_radius.dart';
import '/core/styles/app_spacing.dart';
import '/utils/assets/custom_images.dart';
import 'custom_progress_indicator.dart';

class HomeBannerCarousel extends StatefulWidget {
  const HomeBannerCarousel({super.key});

  @override
  State<HomeBannerCarousel> createState() => _HomeBannerCarouselState();
}

class _HomeBannerCarouselState extends State<HomeBannerCarousel> {
  int _screenIndex = 0;

  void _onPageChanged(int value) => setState(() => _screenIndex = value);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 250,
          child: PageView.builder(
            itemCount: CustomImages.homeImages.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (_, index) => Container(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenHorizontal,
                AppSpacing.sm,
                AppSpacing.screenHorizontal,
                AppSpacing.xl,
              ),
              decoration: const BoxDecoration(borderRadius: AppRadius.lgAll),
              child: ClipRRect(
                borderRadius: AppRadius.lgAll,
                child: Image.asset(
                  CustomImages.homeImages[index],
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        CustomProgressIndicator(
          screenIndex: _screenIndex,
          progressLength: CustomImages.homeImages.length,
        ),
      ],
    );
  }
}
