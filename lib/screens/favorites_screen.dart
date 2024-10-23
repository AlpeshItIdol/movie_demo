import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_discovery_bloc/bloc_cubit/fav_cubit.dart';
import '../bloc_cubit/fav_state.dart';


class FavoritesScreen extends StatefulWidget {
  static const routeName = 'favoritesScreen-page';
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FavCubit>(context).fetchFavMovies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorite Movies')),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<FavCubit, FavState>(
              builder: (context, state) {
                if (state is FavLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is FavLoaded) {
                  return ListView.builder(
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.network("https://m.media-amazon.com/images/M/MV5BYWRjNGM2MGEtOTllMy00OWY2LTgxNjEtODI1ZDkxYzM3Nzc0XkEyXkFqcGc@._V1_SX300.jpg", width: 50, fit: BoxFit.cover),
                        title: Text(state.movies[index]),
                        subtitle: Text(state.movies[index]),
                        trailing: IconButton(
                          icon: Icon(Icons.favorite),
                          color: Colors.red ,
                          onPressed: (){}
                        ),
                        onTap: () {
                        },
                      );
                    },
                  );
                } else if (state is FavError) {
                  return Center(child: Text(state.message));
                }
                return Center(child: Text('No movies found.'));
              },
            ),
          ),
        ],
      )
    );
  }
}
