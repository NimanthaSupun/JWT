


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  final String baseUrl = 'http://192.168.1.7:5000/api/favorites';

  // Add wallpaper to favorites
  Future<void> addToFavorites({
    required String id,
    required String url,
    required String description,
    required String photographer,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      print(token);

      final response = await http.post(
        Uri.parse('$baseUrl/add'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': token!,
        },
        body: jsonEncode({
          'id': id,
          'url': url,
          'description': description,
          'photographer': photographer,
        }),
      );

      print(response.body);

      if (response.statusCode != 200) {
        throw Exception('Failed to add to favorites');
      }
    } catch (e) {
      print('Error adding to favorites: $e');
      throw Exception('Failed to add to favorites');
    }
  }

  // Remove wallpaper from favorites
  Future<void> removeFromFavorites(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('$baseUrl/remove'),
      headers: {
        'Content-Type': 'application/json',
        'x-auth-token': token!,
      },
      body: jsonEncode({'id': id}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to remove from favorites');
    }
  }

  // Get user's favorite wallpapers
  Future<List<dynamic>> getFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$baseUrl/list'),
      headers: {
        'x-auth-token': token!,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch favorites');
    }
  }
}
