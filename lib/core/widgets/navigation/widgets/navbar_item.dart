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
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(itemIcon, color: active ? Colors.white : Colors.white54),
          Text(
            itemText,
            style: TextStyle(
              color: active ? Colors.white : Colors.white54,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
