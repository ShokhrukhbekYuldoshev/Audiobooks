import 'package:audiobooks/src/core/helpers/helpers.dart';
import 'package:audiobooks/src/core/router/app_router.dart';
import 'package:audiobooks/src/domain/entities/audiobook_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AudiobookWidget extends StatelessWidget {
  const AudiobookWidget({
    super.key,
    required this.audiobook,
  });

  final AudiobookEntity audiobook;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRouter.audiobookDetailsRoute,
          arguments: audiobook,
        );
      },
      child: Column(
        children: [
          Hero(
            tag: audiobook.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child:
                  canLoadImage(audiobook.rssFeed?.channel.itunesImageHref ?? "")
                      ? CachedNetworkImage(
                          imageUrl:
                              audiobook.rssFeed?.channel.itunesImageHref ?? "",
                          placeholder: (context, url) => const SizedBox(),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/cover.jpg',
                          ),
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/cover.jpg',
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
            ),
          ),
          Text(audiobook.title),
        ],
      ),
    );
  }
}
