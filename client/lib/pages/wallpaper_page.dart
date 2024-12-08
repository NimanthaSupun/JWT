import 'package:flutter/material.dart';
import 'package:wallpaper/models/wallpaper_model.dart';
import 'package:wallpaper/services/wallpaper_service.dart';
import 'package:wallpaper/widgets/reusable/custom_button.dart';
import 'package:wallpaper/widgets/reusable/custom_input.dart';

class WallpaperPage extends StatefulWidget {
  const WallpaperPage({super.key});

  @override
  State<WallpaperPage> createState() => _WallpaperPageState();
}

class _WallpaperPageState extends State<WallpaperPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Wallpaper> _wallpapers = [];
  bool _isLoading = false;

  void _searchWallpapers() async {
    setState(() {
      _isLoading = true;
    });

    String searchQuery = _searchController.text;
    try {
      final List<Wallpaper> wallpapers =
          await WallpaperService().searchWallpapers(query: searchQuery);
      setState(() {
        _wallpapers = wallpapers;
      });
    } catch (error) {
      print(error);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            CustomInput(
              controller: _searchController,
              labalText: "Serach wallpapers",
              obsecureText: false,
              validator: (value) =>
                  value!.isEmpty ? "please enter a search term" : null,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
              isLoading: _isLoading,
              onPresed: _searchWallpapers,
              labelText: "Search",
            ),
            const SizedBox(
              height: 12,
            ),
            _isLoading
                ? const Center(
                    child: SizedBox(),
                  )
                : Expanded(
                    child: _wallpapers.isNotEmpty
                        ? GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 2 / 3,
                            ),
                            itemCount: _wallpapers.length,
                            itemBuilder: (context, index) {
                              final wallpaper = _wallpapers[index];
                              return GestureDetector(
                                onTap: () {                                  
                                },
                                child: Card(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Image.network(
                                          wallpaper.url,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                       Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          wallpaper.description,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Text(
                                          "By ${wallpaper.photographer}",
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: Text("No Wallpaper Found"),
                          )),
          ],
        ),
      ),
    );
  }
}
