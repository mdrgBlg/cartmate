import 'package:flutter/material.dart';

import '../../../../constants/custom_colors.dart';

class InformationWidget extends StatelessWidget {
  final String sectionTitle;
  final String sectionText;
  const InformationWidget({
    super.key,
    required this.sectionTitle,
    required this.sectionText,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 20),
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
          const Spacer(),
          const Padding(
            padding: EdgeInsets.only(right: 20),
            child: InkWell(
              child: Icon(
                Icons.arrow_forward_ios,
                color: CustomColors.grayDark,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
