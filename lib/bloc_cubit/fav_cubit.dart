
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/fav_service.dart';
import 'fav_state.dart';

class FavCubit extends Cubit<FavState> {
  final FavoriteMoviesService favService;

  FavCubit(this.favService) : super(FavInitial());

  void fetchFavMovies() async {
    try {
      emit(FavLoading());
      final movies = await favService.getFavoriteMovies();
      emit(FavLoaded(movies));
    } catch (e) {
      emit(FavError('Failed to fetch popular movies'));
    }
  }
}
