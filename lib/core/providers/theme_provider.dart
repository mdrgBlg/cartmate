import 'package:flutter/material.dart';

import '/data/models/result.dart';
import '/data/repositories/theme_repository.dart';

class ThemeProvider with ChangeNotifier {
  ThemeProvider({required ThemeRepository themeRepository})
    : _themeRepository = themeRepository {
    load();
  }

  final ThemeRepository _themeRepository;

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  Exception? _error;
  bool get hasError => _error != null;

  // Started from the constructor. Never throws: a read failure falls back to
  // the system mode.
  Future<void> load() async {
    _error = null;
    final result = await _themeRepository.getThemeMode();
    switch (result) {
      case Success(:final data):
        _themeMode = data;
      case Failure(:final exception):
        _themeMode = ThemeMode.system;
        _error = exception;
    }
    notifyListeners();
  }

  // Applies the mode at once; if saving fails the mode is kept for this
  // session only.
  Future<bool> setThemeMode(ThemeMode mode) async {
    if (mode == _themeMode) {
      return true;
    }
    _themeMode = mode;
    _error = null;
    notifyListeners();

    final result = await _themeRepository.saveThemeMode(mode);
    switch (result) {
      case Success():
        return true;
      case Failure(:final exception):
        _error = exception;
        notifyListeners();
        return false;
    }
  }
}
