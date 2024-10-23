import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/mobile_service.dart';
import 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final MovieService movieService;

  MovieCubit(this.movieService) : super(MovieInitial());

  void fetchPopularMovies() async {
    try {
      emit(MovieLoading());
      final movies = await movieService.fetchPopularMovies();
      emit(MovieLoaded(movies));
    } catch (e) {
      emit(MovieError('Failed to fetch popular movies'));
    }
  }

  void searchMovies(String query) async {
    try {
      emit(MovieLoading());
      final movies = await movieService.findMovies(query);
      emit(MovieLoaded(movies));
    } catch (e) {
      emit(MovieError('Failed to search movies'));
    }
  }
}
