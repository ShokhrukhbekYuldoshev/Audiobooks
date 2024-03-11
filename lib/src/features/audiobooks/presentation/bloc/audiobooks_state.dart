part of 'audiobooks_bloc.dart';

abstract class AudiobooksState extends Equatable {
  const AudiobooksState();

  @override
  List<Object> get props => [];
}

class AudiobooksInitial extends AudiobooksState {}

class AudiobooksLoading extends AudiobooksState {}

class AudiobooksLoaded extends AudiobooksState {
  final List<AudiobookEntity> audiobooks;

  const AudiobooksLoaded(this.audiobooks);

  @override
  List<Object> get props => [audiobooks];
}

class AudiobooksError extends AudiobooksState {
  final String message;

  const AudiobooksError(this.message);

  @override
  List<Object> get props => [message];
}
