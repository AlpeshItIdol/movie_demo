import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc_cubit/movie_cubit.dart';
import '../bloc_cubit/movie_state.dart';
import '../widgets/movie_tile.dart';
import '../models/movie_model.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home-page';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Movie> _favoriteMovies = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MovieCubit>(context).fetchPopularMovies();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      BlocProvider.of<MovieCubit>(context).searchMovies(query);
    } else {
      BlocProvider.of<MovieCubit>(context).fetchPopularMovies();
    }
  }

  void _toggleFavorite(Movie movie) {
    setState(() {
      if (_favoriteMovies.contains(movie)) {
        _favoriteMovies.remove(movie);
      } else {
        _favoriteMovies.add(movie);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Discovery'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search movies by title...',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<MovieCubit, MovieState>(
              builder: (context, state) {
                if (state is MovieLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is MovieLoaded) {
                  return ListView.builder(
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) {
                      final movie = state.movies[index];
                      return GestureDetector(
                        onTap: () => _toggleFavorite(movie), // Toggle favorite on tap
                        child: MovieTile(movie: movie),
                      );
                    },
                  );
                } else if (state is MovieError) {
                  return Center(child: Text(state.message));
                }
                return Center(child: Text('No movies found.'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
