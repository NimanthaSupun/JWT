
class Wallpaper {
  final String id;
  final String url;
  final String description;
  final String photographer;

  Wallpaper({
    required this.id,
    required this.url,
    required this.description,
    required this.photographer,
  });

  factory Wallpaper.fromJson(Map<String, dynamic> json) {
    return Wallpaper(
      id: json['id'],
      url: json['url'],
      description: json['description'] ?? 'No description',
      photographer: json['photographer'] ?? 'Unknown photographer',
    );
  }
}
