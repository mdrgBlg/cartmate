import 'package:flutter/material.dart';

import '/core/l10n/app_localizations.dart';

extension ThemeModeLabel on ThemeMode {
  String label(AppLocalizations localization) => switch (this) {
    ThemeMode.system => localization.themeModeSystem,
    ThemeMode.light => localization.themeModeLight,
    ThemeMode.dark => localization.themeModeDark,
  };
}
