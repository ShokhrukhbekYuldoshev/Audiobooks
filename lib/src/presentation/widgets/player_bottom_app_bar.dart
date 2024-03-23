import 'package:audiobooks/src/core/di/service_locator.dart';
import 'package:audiobooks/src/core/router/app_router.dart';
import 'package:audiobooks/src/domain/repositories/just_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayerBottomAppBar extends StatefulWidget {
  const PlayerBottomAppBar({
    super.key,
  });

  @override
  State<PlayerBottomAppBar> createState() => _PlayerBottomAppBarState();
}

class _PlayerBottomAppBarState extends State<PlayerBottomAppBar> {
  final player = sl<JustAudioPlayer>();
  bool isPlaying = false;
  SequenceState? sequence;

  int currentIndex = 0; // Initialize currentIndex

  @override
  void initState() {
    super.initState();
    player.playing.listen((playing) {
      setState(() {
        isPlaying = playing;
      });
    });

    player.sequenceState.listen((state) {
      setState(() {
        sequence = state;
      });
    });

    // Listen to currentIndex stream
    player.currentIndex.listen((index) {
      setState(() {
        currentIndex = index ?? 1; // Update currentIndex
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
    return StreamBuilder<int?>(
      stream: player.currentIndex,
      builder: (context, snapshot) {
        final mediaItem = sequence?.sequence[currentIndex];

        if (mediaItem == null) {
          return const SizedBox.shrink();
        } else {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () async {
              Navigator.of(context).pushNamed(
                AppRouter.playerRoute,
                arguments: mediaItem,
              );
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(
                  32,
                ),
                topRight: Radius.circular(
                  32,
                ),
              ),
              child: BottomAppBar(
                child: StreamBuilder<int?>(
                  stream: player.currentIndex,
                  builder: (context, snapshot) {
                    // final currentIndex = snapshot.data ?? 0;
                    return Row(
                      children: [
                        const SizedBox(width: 16),
                        Expanded(
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: mediaItem.tag.artUri.toString(),
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                                placeholder: (context, url) {
                                  return const CircularProgressIndicator();
                                },
                                errorWidget: (context, url, error) {
                                  return const Icon(Icons.error);
                                },
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      mediaItem.tag.title ?? 'Unknown',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      mediaItem.tag.album ?? 'Unknown',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // play/pause button
                        StreamBuilder<bool>(
                          stream: player.playing,
                          builder: (context, snapshot) {
                            final playing = snapshot.data ?? false;
                            return Hero(
                              tag: 'play_pause_button',
                              child: IconButton(
                                onPressed: () async {
                                  if (playing) {
                                    await player.pause();
                                  } else {
                                    await player.play();
                                  }
                                },
                                icon: playing
                                    ? const Icon(Icons.pause_rounded)
                                    : const Icon(Icons.play_arrow_rounded),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 16),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
