import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:e_commerce/constants/global_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  static Future<void> login(String email, String password) async {
    final url = GlobalUrl.getUrl("signInWithPassword");
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        accessToken(responseData["idToken"]);
      } else if (responseData["error"] != null) {}
    } catch (e) {
      log("Exception sign up: $e");
    }
  }

  static void accessToken(String response) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString("token", response);
  }
}
