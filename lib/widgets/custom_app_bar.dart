import 'package:flutter/material.dart';

import '/utils/constants/custom_colors.dart';

enum AppBarType {
  light,
  dark;

  Color get foregroundColor => switch (this) {
    light => CustomColors.secondary,
    dark => Colors.white,
  };

  Color get backgroundColor => switch (this) {
    light => CustomColors.primary,
    dark => Colors.black,
  };
  Color? get titleTextColor => switch (this) {
    light => CustomColors.secondary,
    dark => null,
  };
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    this.titleText,
    this.type = AppBarType.light,
    this.title,
    super.key,
  });
  final String? titleText;
  final AppBarType type;
  final Widget? title;

  static const double appBarHeight = 52;

  @override
  Size get preferredSize => const Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppBar(
      toolbarHeight: appBarHeight,
      backgroundColor: type.backgroundColor,
      foregroundColor: type.foregroundColor,
      elevation: 0,
      titleSpacing: 4,
      title:
          title ??
          Text(
            titleText ?? '',
            style: textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: type.titleTextColor,
            ),
          ),
    );
  }
}
