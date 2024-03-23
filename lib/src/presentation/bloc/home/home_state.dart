part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<AudiobookEntity> audiobooks;
  final List<AuthorEntity> authors;

  const HomeLoaded({
    required this.audiobooks,
    required this.authors,
  });

  @override
  List<Object> get props => [audiobooks, authors];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}
