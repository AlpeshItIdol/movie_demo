import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_discovery_bloc/screens/favorites_screen.dart';
import 'package:movie_discovery_bloc/services/fav_service.dart';
import 'package:movie_discovery_bloc/services/mobile_service.dart';
import 'bloc_cubit/fav_cubit.dart';
import 'bloc_cubit/movie_cubit.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MovieCubit(MovieService())..fetchPopularMovies(),
        ),
        BlocProvider(
          create: (context) => FavCubit(FavoriteMoviesService()),
        ),
      ],
      child: MaterialApp(
        title: 'Movie Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: "/",
        routes: {
          '/': (context) => HomeScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          FavoritesScreen.routeName: (context) => FavoritesScreen(),
        },
      ),
    );
  }
}
