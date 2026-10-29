import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/result.dart';

class ThemeModeService {
  static const storageKey = 'theme_mode';

  Future<Result<String?>> readThemeMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return Success(prefs.getString(storageKey));
    } catch (e) {
      log("Exception readThemeMode: $e");
      return Failure(Exception(e));
    }
  }

  Future<Result<void>> writeThemeMode(String value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = await prefs.setString(storageKey, value);
      if (!saved) {
        return Failure(Exception('Could not save theme mode'));
      }
      return const Success<void>(null);
    } catch (e) {
      log("Exception writeThemeMode: $e");
      return Failure(Exception(e));
    }
  }
}
