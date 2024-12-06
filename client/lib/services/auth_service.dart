import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = "http://192.168.1.7:5000/api/auth";

  // todo: Register new User
  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/register"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
          {
            "username": username,
            "email": email,
            "password": password,
          },
        ),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to register");
      }
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  // todo: Login User

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/login"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
          {
            "email": email,
            "password": password,
          },
        ),
      );
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        // store the shared preferences
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString("token", result["token"]);
        return result;
      } else {
        throw Exception("Failed to login");
      }
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  //todo: logout
  Future<void> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("token");
    print("Log out");
  }

  //todo: get jwt token
  Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("token");
  }
}
