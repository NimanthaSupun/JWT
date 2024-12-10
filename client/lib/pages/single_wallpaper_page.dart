import 'package:flutter/material.dart';
import 'package:wallpaper/models/wallpaper_model.dart';
import 'package:wallpaper/pages/login.dart';
import 'package:wallpaper/services/auth_service.dart';
import 'package:wallpaper/services/favourite_service.dart';
import 'package:wallpaper/widgets/reusable/custom_button.dart';

class SingleWallpaperPage extends StatelessWidget {
  final Wallpaper wallpaper;
  const SingleWallpaperPage({super.key, required this.wallpaper});

  // add fav

  void _addToFavourites(Wallpaper wallpaper, BuildContext context) async {
    try {
      await FavoriteService().addToFavorites(
        id: wallpaper.id,
        url: wallpaper.url,
        description: wallpaper.description,
        photographer: wallpaper.photographer,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Added to favourites"),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print(e.toString());
      if (e.toString().contains("Token is not valid") ||
          e.toString().contains("Token has expired") ||
          e.toString().contains("No valid token found")) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("You need to login again"),
            duration: Duration(seconds: 2),
          ),
        );

        AuthService().logout();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error adding to favourite, please try again"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallpaper details"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Image.network(
              wallpaper.url,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  wallpaper.description,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Photographer: ${wallpaper.photographer}",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomButton(
                  isLoading: false,
                  onPresed: () {
                    _addToFavourites(wallpaper, context);
                  },
                  labelText: "Add Favourite",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
