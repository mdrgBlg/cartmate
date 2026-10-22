import 'package:flutter/material.dart';

import '/constants/custom_images.dart';
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
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
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
