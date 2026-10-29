import 'package:flutter/material.dart';

import '../models/result.dart';
import '../services/theme_mode_service.dart';

class ThemeRepository {
  ThemeRepository({required ThemeModeService themeModeService})
    : _themeModeService = themeModeService;

  final ThemeModeService _themeModeService;

  // A missing or unknown stored value falls back to the system mode.
  Future<Result<ThemeMode>> getThemeMode() async {
    final result = await _themeModeService.readThemeMode();
    switch (result) {
      case Success(:final data):
        return Success(
          ThemeMode.values.firstWhere(
            (mode) => mode.name == data,
            orElse: () => ThemeMode.system,
          ),
        );
      case Failure(:final exception):
        return Failure(exception);
    }
  }

  Future<Result<void>> saveThemeMode(ThemeMode mode) =>
      _themeModeService.writeThemeMode(mode.name);
}
