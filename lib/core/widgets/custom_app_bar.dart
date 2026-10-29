import 'package:flutter/material.dart';

import '/utils/constants/app_bar_constants.dart';

enum AppBarType {
  light,
  dark;

  Color foregroundColor(ColorScheme colorScheme) => switch (this) {
    light => colorScheme.onPrimary,
    dark => colorScheme.onInverseSurface,
  };

  Color backgroundColor(ColorScheme colorScheme) => switch (this) {
    light => colorScheme.primary,
    dark => colorScheme.inverseSurface,
  };

  Color titleTextColor(ColorScheme colorScheme) => switch (this) {
    light => colorScheme.onPrimary,
    dark => colorScheme.onInverseSurface,
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

  @override
  Size get preferredSize => const Size.fromHeight(AppBarConstants.appBarHeight);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: AppBar(
        toolbarHeight: AppBarConstants.appBarHeight,
        backgroundColor: type.backgroundColor(colorScheme),
        foregroundColor: type.foregroundColor(colorScheme),
        elevation: 0,
        titleSpacing: 4,
        title:
            title ??
            Text(
              titleText ?? '',
              style: textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: type.titleTextColor(colorScheme),
              ),
            ),
      ),
    );
  }
}
