import 'package:flutter/material.dart';
import '../models/movie_model.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  MovieDetailsScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(movie.poster),
            SizedBox(height: 10),
            Text(movie.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('Year: ${movie.year}'),
            Text('Rating: ${movie.rating}'),
            SizedBox(height: 10),
            Text(movie.plot, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
