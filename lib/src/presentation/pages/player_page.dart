import 'package:audiobooks/src/core/helpers/helpers.dart';
import 'package:audiobooks/src/presentation/bloc/player/player_bloc.dart'
    as bloc;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  SequenceState? sequence;

  @override
  void initState() {
    super.initState();

    player.sequenceState.listen((state) {
      setState(() {
        sequence = state;
      });
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

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
                Column(
                  children: [
                    if (sequence != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: loadImage(sequence!),
                      ),
                    const SizedBox(height: 20),
                    if (sequence != null)
                      Text(
                        sequence!.sequence[sequence!.currentIndex].tag.title,
                        style: const TextStyle(fontSize: 24),
                      ),
                    if (sequence != null)
                      Text(
                        sequence!.sequence[sequence!.currentIndex].tag.album,
                        style: const TextStyle(fontSize: 18),
                      ),
                  ],
                ),

                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StreamBuilder<bool>(
                      stream: player.shuffleModeEnabled,
                      builder: (context, snapshot) {
                        return IconButton(
                          onPressed: () {
                            context.read<bloc.PlayerBloc>().add(
                                  bloc.PlayerSetShuffleModeEnabled(
                                    !(snapshot.data ?? false),
                                  ),
                                );
                          },
                          icon: snapshot.data == false
                              ? const Icon(
                                  Icons.shuffle_rounded,
                                  color: Colors.grey,
                                )
                              : const Icon(Icons.shuffle_rounded),
                          iconSize: 30,
                        );
                      },
                    ),
                    // repeat button
                    StreamBuilder<LoopMode>(
                      stream: player.loopMode,
                      builder: (context, snapshot) {
                        return IconButton(
                          onPressed: () {
                            if (snapshot.data == LoopMode.off) {
                              context.read<bloc.PlayerBloc>().add(
                                    bloc.PlayerSetLoopMode(LoopMode.all),
                                  );
                            } else if (snapshot.data == LoopMode.all) {
                              context.read<bloc.PlayerBloc>().add(
                                    bloc.PlayerSetLoopMode(LoopMode.one),
                                  );
                            } else {
                              context.read<bloc.PlayerBloc>().add(
                                    bloc.PlayerSetLoopMode(LoopMode.off),
                                  );
                            }
                          },
                          icon: snapshot.data == LoopMode.off
                              ? const Icon(
                                  Icons.repeat_rounded,
                                  color: Colors.grey,
                                )
                              : snapshot.data == LoopMode.all
                                  ? const Icon(Icons.repeat_rounded)
                                  : const Icon(Icons.repeat_one_rounded),
                          iconSize: 30,
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // seek bar
                StreamBuilder<Duration>(
                  stream: player.position,
                  builder: (context, snapshot) {
                    final position = snapshot.data ?? Duration.zero;
                    return StreamBuilder<Duration?>(
                      stream: player.duration,
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
                              onChanged: (value) async {
                                await player
                                    .seek(Duration(seconds: value.toInt()));
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // seek to previous
                    IconButton(
                      icon: const Icon(Icons.skip_previous),
                      iconSize: 36,
                      onPressed: () {
                        context.read<bloc.PlayerBloc>().add(
                              bloc.PlayerPrevious(),
                            );
                      },
                    ),

                    // rewind button
                    StreamBuilder<Duration>(
                      stream: player.position,
                      builder: (context, snapshot) {
                        final position = snapshot.data ?? Duration.zero;
                        return IconButton(
                          icon: const Icon(Icons.replay_10),
                          iconSize: 36,
                          onPressed: () async {
                            if (position > const Duration(seconds: 10)) {
                              await player.seek(
                                position - const Duration(seconds: 10),
                              );
                            } else {
                              await player.seek(
                                const Duration(seconds: 0),
                              );
                            }
                          },
                        );
                      },
                    ),

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
                                context.read<bloc.PlayerBloc>().add(
                                      bloc.PlayerPause(),
                                    );
                              } else {
                                context.read<bloc.PlayerBloc>().add(
                                      bloc.PlayerPlay(),
                                    );
                              }
                            },
                          ),
                        );
                      },
                    ),

                    // fast forward button
                    StreamBuilder<Duration>(
                      stream: player.position,
                      builder: (context, snapshot) {
                        final position = snapshot.data ?? Duration.zero;
                        return StreamBuilder<Duration?>(
                          stream: player.duration,
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

                    // seek to next button
                    IconButton(
                      icon: const Icon(Icons.skip_next),
                      iconSize: 36,
                      onPressed: () {
                        context.read<bloc.PlayerBloc>().add(
                              bloc.PlayerNext(),
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
