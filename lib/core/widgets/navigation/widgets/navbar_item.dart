import 'package:flutter/material.dart';

class NavBarItem extends StatelessWidget {
  const NavBarItem({
    required this.itemIcon,
    required this.itemText,
    required this.onTap,
    this.active = false,
    super.key,
  });
  final IconData itemIcon;
  final String itemText;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final color = active
        ? colorScheme.onPrimary
        : colorScheme.onPrimary.withValues(alpha: 0.54);

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(itemIcon, color: color),
          Text(itemText, style: textTheme.bodyMedium!.copyWith(color: color)),
        ],
      ),
    );
  }
}
