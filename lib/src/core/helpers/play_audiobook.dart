import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:audiobooks/src/core/di/service_locator.dart';
import 'package:audiobooks/src/core/helpers/helpers.dart';
import 'package:audiobooks/src/core/network/network_info.dart';
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

  String url = item.enclosureUrl;
  bool networkConnected = await sl<NetworkInfo>().isConnected;
  bool fileExists = await isFileExists(item.enclosureUrl.split('/').last);

  // Check if file exists
  if (fileExists) {
    final directory = await getExternalStorageDirectory();
    url = '${directory!.path}/${item.enclosureUrl.split('/').last}';
  }
  // if network is not connected and file does not exist
  else if (!networkConnected && context.mounted) {
    return showSnackBar(
      context,
      "No internet connection",
    );
  }

  // Play the audiobook
  final player = sl<JustAudioPlayer>();
  await player.load(
    url,
    item.episode,
    item.title,
    audiobook.title,
    audiobook.rssFeed!.channel.itunesImageHref,
  );
  await player.play();
}
