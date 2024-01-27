import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:e_commerce/constants/global_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  static Future<bool> login(String email, String password) async {
    final preferences = await SharedPreferences.getInstance();
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
        log(response.body);
        preferences.setString("token", responseData["idToken"]);
        return true;
      } else if (responseData["error"] != null) {
        return false;
      }
    } catch (e) {
      log("Exception sign up: $e");
    }
    return false;
  }
}
