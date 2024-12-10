import 'package:flutter/material.dart';
import 'package:wallpaper/models/wallpaper_model.dart';
import 'package:wallpaper/widgets/reusable/custom_button.dart';

class SingleWallpaperPage extends StatelessWidget {
  final Wallpaper wallpaper;
  const SingleWallpaperPage({super.key, required this.wallpaper});

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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  wallpaper.description,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 8,),
                Text(
                  "Photographer: ${wallpaper.photographer}",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
               const SizedBox(height: 8,),
               CustomButton(
                isLoading: false,
                onPresed: (){},
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
