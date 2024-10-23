import 'package:equatable/equatable.dart';


abstract class FavState extends Equatable {
  @override
  List<Object> get props => [];
}

class FavInitial extends FavState {}

class FavLoading extends FavState {}

class FavLoaded extends FavState {
  final List<String> movies;
  FavLoaded(this.movies);
}

class FavError extends FavState {
  final String message;
  FavError(this.message);
}
