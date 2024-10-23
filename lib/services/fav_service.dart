import 'package:shared_preferences/shared_preferences.dart';

class FavoriteMoviesService {
  final String _favoriteMoviesKey = 'favorite_movies';

  Future<void> addFavorite(String movieTitle) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_favoriteMoviesKey) ?? [];
    favorites.add(movieTitle);
    await prefs.setStringList(_favoriteMoviesKey, favorites);
  }

  Future<void> removeFavorite(String movieTitle) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_favoriteMoviesKey) ?? [];
    favorites.remove(movieTitle);
    await prefs.setStringList(_favoriteMoviesKey, favorites);
  }

  Future<bool> isFavorite(String movieTitle) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_favoriteMoviesKey) ?? [];
    return favorites.contains(movieTitle);
  }

  Future<List<String>> getFavoriteMovies() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoriteMoviesKey) ?? [];
  }
}
