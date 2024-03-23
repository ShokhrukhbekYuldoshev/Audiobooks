import 'dart:io';

import 'package:audiobooks/src/core/network/network_info.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:audiobooks/src/core/di/service_locator.dart';
import 'package:audiobooks/src/core/helpers/helpers.dart';
import 'package:audiobooks/src/core/helpers/play_audiobook.dart';
import 'package:audiobooks/src/domain/entities/audiobook_entity.dart';
import 'package:audiobooks/src/domain/entities/rss_entity.dart';
import 'package:audiobooks/src/domain/repositories/just_audio_player.dart';
import 'package:audiobooks/src/presentation/widgets/player_bottom_app_bar.dart';

class AudiobookDetailsPage extends StatefulWidget {
  final AudiobookEntity audiobook;

  const AudiobookDetailsPage({super.key, required this.audiobook});

  @override
  State<AudiobookDetailsPage> createState() => _AudiobookDetailsPageState();
}

class _AudiobookDetailsPageState extends State<AudiobookDetailsPage> {
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

  Color calculateTextColor(Color background) {
    return background.computeLuminance() >= 0.5 ? Colors.black : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const PlayerBottomAppBar(),
      floatingActionButton: _buildFAB(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              title: LayoutBuilder(
                builder: (context, constraints) {
                  bool isDark = constraints.maxHeight > 100;
                  return Text(
                    widget.audiobook.title,
                    style: TextStyle(
                      color: isDark
                          ? Colors.white
                          : calculateTextColor(
                              Theme.of(context).scaffoldBackgroundColor,
                            ),
                    ),
                  );
                },
              ),
              background: Hero(
                tag: widget.audiobook.id,
                child: canLoadImage(
                        widget.audiobook.rssFeed!.channel.itunesImageHref)
                    ? CachedNetworkImage(
                        imageUrl:
                            widget.audiobook.rssFeed!.channel.itunesImageHref,
                        placeholder: (context, url) => const SizedBox(),
                        color: Colors.black.withOpacity(0.5),
                        colorBlendMode: BlendMode.darken,
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/cover.jpg',
                          fit: BoxFit.cover,
                          color: Colors.black.withOpacity(0.5),
                          colorBlendMode: BlendMode.darken,
                        ),
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/cover.jpg',
                        fit: BoxFit.cover,
                        color: Colors.black.withOpacity(0.5),
                        colorBlendMode: BlendMode.darken,
                      ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: Wrap(
                    children: [
                      Text(
                        widget.audiobook.authors.length > 1
                            ? "Authors: "
                            : "Author: ",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        widget.audiobook.authors
                            .map((e) => e.fullName)
                            .join(", "),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: HtmlWidget(
                    widget.audiobook.description,
                    onTapUrl: (url) async {
                      if (await canLaunchUrlString(url)) {
                        return await launchUrlString(
                          url,
                        );
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10),

                // contents
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: Wrap(
                    children: [
                      Text(
                        "Contents: ",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        widget.audiobook.rssFeed!.channel.items.length
                            .toString(),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ContentList(audiobook: widget.audiobook),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAB() {
    return sequence != null
        ? const SizedBox()
        : FloatingActionButton(
            onPressed: () async {
              await playAudiobook(
                context,
                widget.audiobook,
                widget.audiobook.rssFeed!.channel.items.first,
              );
            },
            child: const Icon(Icons.play_arrow),
          );
  }
}

class ContentList extends StatefulWidget {
  final AudiobookEntity audiobook;
  const ContentList({super.key, required this.audiobook});

  @override
  State<ContentList> createState() => _ContentListState();
}

class _ContentListState extends State<ContentList> {
  int _itemsToShow = 6; // show 5 items initially and then show more
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _itemsToShow > widget.audiobook.rssFeed!.channel.items.length
          ? widget.audiobook.rssFeed!.channel.items.length
          : _itemsToShow,
      itemBuilder: (context, index) {
        final item = widget.audiobook.rssFeed!.channel.items[index];
        if (index == _itemsToShow - 1) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _itemsToShow += 5;
                });
              },
              child: const Text("Show more"),
            ),
          );
        }

        return ContentItem(item: item, widget: widget);
      },
    );
  }
}

class ContentItem extends StatelessWidget {
  const ContentItem({
    super.key,
    required this.item,
    required this.widget,
  });

  final RssItemEntity item;
  final ContentList widget;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      offset: const Offset(1, 0),
      onSelected: (value) async {
        if (value == "download") {
          await downloadItem(context);
        }
        if (value == "play" && context.mounted) {
          await playAudiobook(context, widget.audiobook, item);
        }
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            value: "play",
            child: ListTile(
              title: Text("Play"),
            ),
          ),
          const PopupMenuItem(
            value: "download",
            child: ListTile(
              title: Text("Download"),
            ),
          ),
        ];
      },
      child: ListTile(
        title: Text(item.title),
        subtitle: Text(item.episode),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // show if the file is downloaded
            if (context.mounted)
              FutureBuilder<bool>(
                future: isFileExists(item.enclosureUrl.split('/').last),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData && snapshot.data!) {
                      return const Icon(Icons.download_done);
                    }
                  }
                  return const SizedBox();
                },
              ),
            const SizedBox(width: 10),
            Text(item.duration),
          ],
        ),
      ),
    );
  }

  Future<void> downloadItem(context) async {
    if (await isFileExists(item.enclosureUrl.split('/').last)) {
      return showSnackBar(context, "File already exists");
    }

    bool networkConnected = await sl<NetworkInfo>().isConnected;
    if (!networkConnected) {
      return showSnackBar(context, "No internet connection");
    }

    Directory? savedDir = await getExternalStorageDirectory();
    await FlutterDownloader.enqueue(
      url: item.enclosureUrl,
      headers: {}, // optional: header send with url (auth token etc)
      savedDir: savedDir!.path,
      showNotification:
          true, // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
    );
  }
}
