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
      // Perform the login request
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      // Log the response status and body for debugging purposes
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      // Check if the response is successful (status code 200)
      if (response.statusCode == 200) {
        // Decode the response body
        final result = jsonDecode(response.body);

        // Store the token in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', result['token']);

        // Retrieve the token for verification
        final token = await prefs.getString('token');
        print('Stored Token: $token');

        // Return the result
        return result;
      } else {
        // Log and throw an exception with more details for non-200 responses
        print('Failed to login - Status Code: ${response.statusCode}');
        print('Response: ${response.body}');
        throw Exception('Failed to login. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Catch and log any errors during the login process
      print('Error during login: $error');
      throw Exception('An error occurred during login: $error');
    }
  }

  // Get stored token
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Logout user
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    print('Logged out');
  }
}
