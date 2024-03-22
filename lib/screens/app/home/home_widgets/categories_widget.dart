import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  final String icon;
  final String categoryName;
  const CategoriesWidget({
    super.key,
    required this.icon,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        children: [
          Container(
            height: 48,
            width: 48,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(99),
              color: Colors.white,
            ),
            child: Image.asset(
              icon,
            ),
          ),
          Flexible(
            child: Container(
              width: 56,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                categoryName,
                style: textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ],
      ),
    );
  }
}
