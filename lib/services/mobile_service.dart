import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class MovieService {
  final String apiKey = '501135aa';
  final String baseUrl= "http://www.omdbapi.com";

  Future<List<Movie>> fetchPopularMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/?s=popular&type=movie&apikey=$apiKey'));

    if (response.statusCode == 200) {
      final List movies = json.decode(response.body)['Search'];
      return movies.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Movie>> findMovies(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/?s=$query&type=movie&apikey=$apiKey'));

    if (response.statusCode == 200) {
      final List movies = json.decode(response.body)['Search'];
      return movies.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
  Future<Movie?> fetchMovieByTitle(String title) async {
    // Encode the title to handle spaces and special characters
    final encodedTitle = Uri.encodeComponent(title);
    final response = await http.get(Uri.parse('$baseUrl/?s=?title=$encodedTitle&api_key=$apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Movie.fromJson(data); // Assuming you have a fromJson method in your Movie model
    } else {
      return null;
    }
  }
  Future<Movie> movieDetails(String imdbID) async {
    final response = await http.get(Uri.parse('$baseUrl/?i=$imdbID&plot=full&apikey=$apiKey'));

    if (response.statusCode == 200) {
      return Movie.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load movie details');
    }
  }
}
