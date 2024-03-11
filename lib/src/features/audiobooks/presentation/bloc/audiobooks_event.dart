part of 'audiobooks_bloc.dart';

abstract class AudiobooksEvent extends Equatable {
  const AudiobooksEvent();

  @override
  List<Object> get props => [];
}

class GetAudiobooksEvent extends AudiobooksEvent {}
