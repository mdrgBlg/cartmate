import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeProvider with ChangeNotifier {
  Future<bool> checkAccessToken() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.remove("token");
    String token = "";
    token = preferences.getString("token")!;
    if (token.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
