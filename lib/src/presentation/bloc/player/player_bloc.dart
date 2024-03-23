import 'package:audiobooks/src/domain/repositories/just_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/foundation.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc({required JustAudioPlayer player}) : super(PlayerInitial()) {
    on<PlayerPlay>((event, emit) async {
      try {
        await player.play();
        emit(PlayerPlaying());
      } catch (e) {
        emit(PlayerError(e.toString()));
      }
    });

    on<PlayerPlayFromQueue>((event, emit) async {
      try {
        await player.seek(Duration.zero);
        await player.play();
        emit(PlayerPlaying());
      } catch (e) {
        emit(PlayerError(e.toString()));
      }
    });

    on<PlayerPause>((event, emit) async {
      try {
        await player.pause();
        emit(PlayerPaused());
      } catch (e) {
        emit(PlayerError(e.toString()));
      }
    });

    on<PlayerStop>((event, emit) async {
      try {
        await player.stop();
        emit(PlayerStopped());
      } catch (e) {
        emit(PlayerError(e.toString()));
      }
    });

    on<PlayerSeek>((event, emit) async {
      try {
        await player.seek(event.position);
        emit(PlayerSeeked(event.position));
      } catch (e) {
        emit(PlayerError(e.toString()));
      }
    });

    on<PlayerNext>((event, emit) async {
      try {
        await player.seekToNext();
        emit(PlayerNexted());
      } catch (e) {
        emit(PlayerError(e.toString()));
      }
    });

    on<PlayerPrevious>((event, emit) async {
      try {
        await player.seekToPrevious();
        emit(PlayerPrevioussed());
      } catch (e) {
        emit(PlayerError(e.toString()));
      }
    });

    on<PlayerSetVolume>((event, emit) async {
      try {
        await player.setVolume(event.volume);
        emit(PlayerVolumeSet(event.volume));
      } catch (e) {
        emit(PlayerError(e.toString()));
      }
    });

    on<PlayerSetSpeed>((event, emit) async {
      try {
        await player.setSpeed(event.speed);
        emit(PlayerSpeedSet(event.speed));
      } catch (e) {
        emit(PlayerError(e.toString()));
      }
    });

    on<PlayerSetLoopMode>((event, emit) async {
      try {
        await player.setLoopMode(event.loopMode);
        emit(PlayerLoopModeSet(event.loopMode));
      } catch (e) {
        emit(PlayerError(e.toString()));
      }
    });

    on<PlayerSetShuffleModeEnabled>((event, emit) async {
      try {
        await player.setShuffleModeEnabled(event.shuffleModeEnabled);
        emit(PlayerShuffleModeEnabledSet(event.shuffleModeEnabled));
      } catch (e) {
        emit(PlayerError(e.toString()));
      }
    });
  }
}
