import 'package:flutter/material.dart';

class NavBarItem extends StatelessWidget {
  final IconData itemIcon;
  final String itemText;
  final bool active;
  final VoidCallback onTap;
  const NavBarItem({
    super.key,
    required this.itemIcon,
    required this.itemText,
    this.active = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            itemIcon,
            color: active ? Colors.white : Colors.white54,
          ),
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
