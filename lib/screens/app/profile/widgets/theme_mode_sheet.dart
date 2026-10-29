import 'package:flutter/material.dart';

import '/core/l10n/app_localizations.dart';
import '/core/styles/app_spacing.dart';
import '/utils/extensions/theme_mode_extension.dart';

class ThemeModeSheet extends StatelessWidget {
  const ThemeModeSheet({
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final ThemeMode selected;
  final ValueChanged<ThemeMode> onSelected;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenHorizontal,
              AppSpacing.lg,
              AppSpacing.screenHorizontal,
              AppSpacing.sm,
            ),
            child: Text(
              localization.profileTheme,
              style: textTheme.titleMedium,
            ),
          ),
          for (final mode in ThemeMode.values)
            ListTile(
              contentPadding: AppSpacing.screenPadding,
              title: Text(mode.label(localization)),
              trailing: mode == selected
                  ? Icon(Icons.check, color: colorScheme.primary)
                  : null,
              onTap: () => onSelected(mode),
            ),
        ],
      ),
    );
  }
}
