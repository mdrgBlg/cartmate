import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce/constants/global_url.dart';
import 'package:http/http.dart' as http;

class SignUpService {
  static Future<bool> signUp(String email, String password) async {
    final url = GlobalUrl.getUrl("signUp");
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

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log("Exception sign up: $e");
    }
    return false;
  }
}
