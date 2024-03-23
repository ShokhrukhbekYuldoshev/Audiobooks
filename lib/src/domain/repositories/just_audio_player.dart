import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

abstract class JustAudioPlayer {
  Future<void> init();
  Future<void> load(
    String url,
    String id,
    String title,
    String album,
    String imageUrl,
  );
  Future<void> play();
  Future<void> pause();
  Future<void> stop();
  Future<void> seek(Duration position);
  Stream<Duration> get position;
  Stream<Duration> get totalDuration;
  Stream<bool> get playing;
  Stream<int?> get currentIndex;
  Stream<SequenceState?> get sequenceState;
  Stream<ProcessingState> get processingStateStream;
  Future<void> dispose();
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
  Future<Duration> load(
    String url,
    String id,
    String title,
    String album,
    String imageUrl,
  ) async {
    final source = AudioSource.uri(
      Uri.parse(url),
      tag: MediaItem(
        id: id,
        title: title,
        album: album,
        artUri: Uri.parse(imageUrl),
      ),
    );
    return await _player.setAudioSource(source) ?? Duration.zero;
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
  Stream<Duration> get position => _player.positionStream;

  @override
  Stream<Duration> get totalDuration => _player.durationStream.map(
        (duration) => duration ?? Duration.zero,
      );

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
}
