import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../screens/movie_detail_screen.dart';
import '../services/fav_service.dart';

class MovieTile extends StatefulWidget {
  final Movie movie;

  MovieTile({required this.movie});

  @override
  _MovieTileState createState() => _MovieTileState();
}

class _MovieTileState extends State<MovieTile> {
  bool isFavorite = false;
  final FavoriteMoviesService _favoriteMoviesService = FavoriteMoviesService();

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    final favorite = await _favoriteMoviesService.isFavorite(widget.movie.title);
    setState(() {
      isFavorite = favorite;
    });
  }

  Future<void> _toggleFavorite() async {
    if (isFavorite) {
      await _favoriteMoviesService.removeFavorite(widget.movie.title);
    } else {
      await _favoriteMoviesService.addFavorite(widget.movie.title);
    }

    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(widget.movie.poster, width: 50, fit: BoxFit.cover),
      title: Text(widget.movie.title),
      subtitle: Text(widget.movie.year),
      trailing: IconButton(
        icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
        color: isFavorite ? Colors.red : null,
        onPressed: _toggleFavorite,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsScreen(movie: widget.movie),
          ),
        );
      },
    );
  }
}
