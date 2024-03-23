import 'package:audiobooks/src/domain/entities/audiobook_entity.dart';
import 'package:audiobooks/src/domain/entities/rss_entity.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:path_provider/path_provider.dart';

import 'package:audiobooks/src/core/helpers/helpers.dart';

abstract class JustAudioPlayer {
  Future<void> init();
  Future<void> load(
    AudiobookEntity audiobook,
    List<RssItemEntity> playlist,
    RssItemEntity item,
  );
  Future<void> play();
  Future<void> pause();
  Future<void> stop();
  Future<void> seek(Duration position);
  Future<void> seekToNext();
  Future<void> seekToPrevious();
  Stream<Duration> get position;
  Stream<Duration?> get duration;
  Stream<bool> get shuffleModeEnabled;
  Stream<LoopMode> get loopMode;
  Stream<bool> get playing;
  Stream<int?> get currentIndex;
  Stream<SequenceState?> get sequenceState;
  Stream<ProcessingState> get processingStateStream;
  Future<void> dispose();
  Future<void> setVolume(double volume);
  Future<void> setSpeed(double speed);
  Future<void> setShuffleModeEnabled(bool enabled);
  Future<void> setLoopMode(LoopMode loopMode);
}

class JustAudioPlayerImpl implements JustAudioPlayer {
  final AudioPlayer _player = AudioPlayer();

  @override
  Future<void> init() async {
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.shokhrukhbek.audiobooks.channel.audio',
      androidNotificationChannelName: 'Audiobooks',
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: true,
    );
  }

  @override
  Future<void> load(
    AudiobookEntity audiobook,
    List<RssItemEntity> playlist,
    RssItemEntity item,
  ) async {
    List<AudioSource> sources = [];

    for (var item in playlist) {
      // if current item is downloaded
      String url = item.enclosureUrl;
      bool fileExists = await isFileExists(item.enclosureUrl.split('/').last);

      // Check if file exists
      if (fileExists) {
        final directory = await getExternalStorageDirectory();
        url = '${directory!.path}/${item.enclosureUrl.split('/').last}';
      }

      sources.add(
        AudioSource.uri(
          Uri.parse(url),
          tag: MediaItem(
            id: item.episode,
            title: item.title,
            album: audiobook.title,
            artUri: Uri.parse(audiobook.rssFeed!.channel.itunesImageHref),
          ),
        ),
      );
    }

    await _player.setAudioSource(
      initialIndex: playlist.indexOf(item),
      ConcatenatingAudioSource(
        children: sources,
      ),
    );

    await _player.play();
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() => _player.stop();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> seekToNext() => _player.seekToNext();

  @override
  Future<void> seekToPrevious() => _player.seekToPrevious();

  @override
  Stream<Duration> get position => _player.positionStream;

  @override
  Stream<Duration?> get duration => _player.durationStream;

  @override
  // shuffle mode enabled
  Stream<bool> get shuffleModeEnabled => _player.shuffleModeEnabledStream;

  @override
  // loop mode
  Stream<LoopMode> get loopMode => _player.loopModeStream;

  @override
  Future<void> dispose() async => await _player.dispose();

  @override
  Stream<bool> get playing => _player.playingStream;

  @override
  Stream<int?> get currentIndex => _player.currentIndexStream;

  @override
  Stream<SequenceState?> get sequenceState => _player.sequenceStateStream;

  @override
  Stream<ProcessingState> get processingStateStream =>
      _player.processingStateStream;

  @override
  Future<void> setVolume(double volume) async {
    await _player.setVolume(volume);
  }

  @override
  Future<void> setSpeed(double speed) async {
    await _player.setSpeed(speed);
  }

  @override
  Future<void> setLoopMode(LoopMode loopMode) async {
    await _player.setLoopMode(loopMode);
  }

  @override
  Future<void> setShuffleModeEnabled(bool enabled) async {
    await _player.setShuffleModeEnabled(enabled);
  }
}
