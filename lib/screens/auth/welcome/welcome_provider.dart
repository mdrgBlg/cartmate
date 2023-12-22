import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeProvider with ChangeNotifier {
  Future<bool> checkAccessToken() async {
    final preferences = await SharedPreferences.getInstance();
    String token = "";
    token = preferences.getString("token")!;
    if (token.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
