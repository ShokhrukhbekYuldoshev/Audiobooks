import 'package:audiobooks/src/core/network/network_info.dart';
import 'package:flutter/material.dart';

import 'package:audiobooks/src/core/di/service_locator.dart';
import 'package:audiobooks/src/core/helpers/helpers.dart';
import 'package:audiobooks/src/domain/entities/audiobook_entity.dart';
import 'package:audiobooks/src/domain/entities/rss_entity.dart';
import 'package:audiobooks/src/domain/repositories/just_audio_player.dart';

Future<void> playAudiobook(
  BuildContext context,
  AudiobookEntity audiobook,
  RssItemEntity item,
) async {
  if (audiobook.rssFeed!.channel.items.isEmpty) {
    return showSnackBar(
      context,
      "No episodes found for ${audiobook.title}",
    );
  }

  // Play the audiobook
  final player = sl<JustAudioPlayer>();

  List<RssItemEntity> playlist = List.generate(
    audiobook.rssFeed!.channel.items.length,
    (index) {
      final item = audiobook.rssFeed!.channel.items[index];
      return item;
    },
  );

  if (playlist.isEmpty) {
    return;
  }

  // if current item is downloaded
  bool networkConnected = await sl<NetworkInfo>().isConnected;
  bool fileExists = await isFileExists(item.enclosureUrl.split('/').last);

  // Check if file exists
  if (fileExists) {
  }
  // if network is not connected and file does not exist
  else if (!networkConnected && context.mounted) {
    return showSnackBar(
      context,
      "No internet connection",
    );
  }

  await player.load(audiobook, playlist, item);
}
