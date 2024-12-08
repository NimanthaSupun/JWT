import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wallpaper/models/wallpaper_model.dart';

class WallpaperService {
  final String _baseUrl = 'http://192.168.1.7:5000/api/wallpaper/search';

  Future<List<Wallpaper>> searchWallpapers({required String query}) async {
    final response = await http.get(Uri.parse('$_baseUrl?query=$query'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)["wallpapers"];
      return data
          .map((wallpaperJson) => Wallpaper.fromJson(wallpaperJson))
          .toList();
    } else {
      throw Exception("Failed to load Wallpapers");
    }
  }
}
