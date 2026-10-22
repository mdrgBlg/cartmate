import 'package:flutter/material.dart';

import '/utils/constants/custom_colors.dart';

class InformationWidget extends StatelessWidget {
  const InformationWidget({
    required this.sectionTitle,
    required this.sectionText,
    required this.onTap,
    super.key,
  });

  final String sectionTitle;
  final String sectionText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                sectionTitle,
                style: textTheme.bodyMedium!.copyWith(
                  color: CustomColors.grayDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                sectionText,
                style: textTheme.bodyMedium!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: CustomColors.grayDark,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
