part of 'player_bloc.dart';

@immutable
sealed class PlayerEvent {}

class PlayerPlay extends PlayerEvent {}

class PlayerPlayFromQueue extends PlayerEvent {
  final int index;

  PlayerPlayFromQueue(this.index);
}

class PlayerPause extends PlayerEvent {}

class PlayerStop extends PlayerEvent {}

class PlayerSeek extends PlayerEvent {
  final Duration position;

  PlayerSeek(this.position);
}

class PlayerNext extends PlayerEvent {}

class PlayerPrevious extends PlayerEvent {}

class PlayerShuffle extends PlayerEvent {}

class PlayerSetVolume extends PlayerEvent {
  final double volume;

  PlayerSetVolume(this.volume);
}

class PlayerSetSpeed extends PlayerEvent {
  final double speed;

  PlayerSetSpeed(this.speed);
}

class PlayerSetLoopMode extends PlayerEvent {
  final LoopMode loopMode;

  PlayerSetLoopMode(this.loopMode);
}

class PlayerSetShuffleModeEnabled extends PlayerEvent {
  final bool shuffleModeEnabled;

  PlayerSetShuffleModeEnabled(this.shuffleModeEnabled);
}
