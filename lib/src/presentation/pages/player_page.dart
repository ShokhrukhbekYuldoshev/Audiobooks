import 'package:audiobooks/src/core/helpers/helpers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'package:audiobooks/src/core/di/service_locator.dart';
import 'package:audiobooks/src/domain/repositories/just_audio_player.dart';

class PlayerPage extends StatefulWidget {
  final ProgressiveAudioSource source;
  const PlayerPage({super.key, required this.source});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  final player = sl<JustAudioPlayer>();
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Player'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder<SequenceState?>(
                  stream: player.sequenceState,
                  builder: (context, snapshot) {
                    final sequence = snapshot.data;
                    return Column(
                      children: [
                        if (sequence != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: loadImage(sequence),
                          ),
                        const SizedBox(height: 20),
                        if (sequence != null)
                          Text(
                            sequence.sequence[sequence.currentIndex].tag.title,
                            style: const TextStyle(fontSize: 24),
                          ),
                        if (sequence != null)
                          Text(
                            sequence.sequence[sequence.currentIndex].tag.album,
                            style: const TextStyle(fontSize: 18),
                          ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 40),

                // seek bar
                StreamBuilder<Duration>(
                  stream: player.position,
                  builder: (context, snapshot) {
                    final position = snapshot.data ?? Duration.zero;
                    return StreamBuilder<Duration>(
                      stream: player.totalDuration,
                      builder: (context, snapshot) {
                        final duration = snapshot.data ?? Duration.zero;
                        return Column(
                          children: [
                            Slider(
                              value: duration > position
                                  ? position.inSeconds.toDouble()
                                  : duration.inSeconds.toDouble(),
                              min: 0,
                              max: duration.inSeconds.toDouble(),
                              onChanged: (value) {
                                player.seek(Duration(seconds: value.toInt()));
                              },
                            ),
                            const SizedBox(height: 10),
                            // position and duration text
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${position.inMinutes.toString().padLeft(2, '0')}:${(position.inSeconds % 60).toString().padLeft(2, '0')}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // rewind button
                    StreamBuilder<Duration>(
                      stream: player.position,
                      builder: (context, snapshot) {
                        final position = snapshot.data ?? Duration.zero;
                        return IconButton(
                          icon: const Icon(Icons.replay_10),
                          iconSize: 36,
                          onPressed: () {
                            if (position > const Duration(seconds: 10)) {
                              player
                                  .seek(position - const Duration(seconds: 10));
                            } else {
                              player.seek(const Duration(seconds: 0));
                            }
                          },
                        );
                      },
                    ),

                    const SizedBox(width: 16),

                    // play/pause button
                    StreamBuilder<bool>(
                      stream: player.playing,
                      builder: (context, snapshot) {
                        final isPlaying = snapshot.data ?? false;
                        return Hero(
                          tag: 'play_pause_button',
                          child: IconButton(
                            icon: Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                            ),
                            iconSize: 36,
                            onPressed: () {
                              if (isPlaying) {
                                player.pause();
                              } else {
                                player.play();
                              }
                            },
                          ),
                        );
                      },
                    ),

                    const SizedBox(width: 16),

                    // fast forward button
                    StreamBuilder<Duration>(
                      stream: player.position,
                      builder: (context, snapshot) {
                        final position = snapshot.data ?? Duration.zero;
                        return StreamBuilder<Duration>(
                          stream: player.totalDuration,
                          builder: (context, snapshot) {
                            final duration = snapshot.data ?? Duration.zero;
                            return IconButton(
                              icon: const Icon(Icons.forward_10),
                              iconSize: 36,
                              onPressed: () async {
                                if (position + const Duration(seconds: 10) <
                                    duration) {
                                  await player.seek(
                                      position + const Duration(seconds: 10));
                                } else {
                                  await player.seek(duration);
                                }
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loadImage(SequenceState sequence) {
    if (canLoadImage(
        sequence.sequence[sequence.currentIndex].tag.artUri.toString())) {
      return CachedNetworkImage(
        imageUrl:
            sequence.sequence[sequence.currentIndex].tag.artUri.toString(),
        errorWidget: (context, url, error) => Image.asset(
          'assets/images/cover.jpg',
        ),
      );
    }

    return Image.asset(
      'assets/images/cover.jpg',
    );
  }
}
