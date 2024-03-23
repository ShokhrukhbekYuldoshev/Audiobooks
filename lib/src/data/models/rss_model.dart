import 'package:audiobooks/src/domain/entities/rss_entity.dart';

class RssFeedModel extends RssFeedEntity {
  RssFeedModel({
    required super.channel,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'channel': channel.toModel().toMap(),
    };
  }

  @override
  factory RssFeedModel.fromMap(Map<String, dynamic> map) {
    return RssFeedModel(
      channel: RssChannelModel.fromMap(map['channel'] as Map<String, dynamic>),
    );
  }
}

class RssChannelModel extends RssChannelEntity {
  RssChannelModel({
    required super.title,
    required super.link,
    required super.description,
    required super.language,
    required super.items,
    required super.itunesType,
    required super.itunesAuthor,
    required super.itunesSummary,
    required super.itunesOwnerName,
    required super.itunesOwnerEmail,
    required super.itunesCategoryText,
    required super.itunesCategoryText2,
    required super.itunesImageHref,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'link': link,
      'description': description,
      'language': language,
      'itunesType': itunesType,
      'itunesAuthor': itunesAuthor,
      'itunesSummary': itunesSummary,
      'itunesOwnerName': itunesOwnerName,
      'itunesOwnerEmail': itunesOwnerEmail,
      'itunesCategoryText': itunesCategoryText,
      'itunesCategoryText2': itunesCategoryText2,
      'itunesImageHref': itunesImageHref,
      'items': items.map((x) => x.toModel().toMap()).toList(),
    };
  }

  @override
  factory RssChannelModel.fromMap(Map<String, dynamic> map) {
    return RssChannelModel(
      title: map['title'] as String,
      link: map['link'] as String,
      description: map['description'] as String,
      language: map['language'] as String,
      itunesType: map['itunesType'] as String,
      itunesAuthor: map['itunesAuthor'] as String,
      itunesSummary: map['itunesSummary'] as String,
      itunesOwnerName: map['itunesOwnerName'] as String,
      itunesOwnerEmail: map['itunesOwnerEmail'] as String,
      itunesCategoryText: map['itunesCategoryText'] as String,
      itunesCategoryText2: map['itunesCategoryText2'] as String,
      itunesImageHref: map['itunesImageHref'] as String,
      items: (map['items'] as List)
          .map((x) => RssItemModel.fromMap(x as Map<String, dynamic>))
          .toList(),
    );
  }
}

class RssItemModel extends RssItemEntity {
  RssItemModel({
    required super.title,
    required super.episode,
    required super.link,
    required super.enclosureUrl,
    required super.enclosureLength,
    required super.enclosureType,
    required super.explicit,
    required super.block,
    required super.duration,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'episode': episode,
      'link': link,
      'enclosureUrl': enclosureUrl,
      'enclosureLength': enclosureLength,
      'enclosureType': enclosureType,
      'explicit': explicit,
      'block': block,
      'duration': duration,
    };
  }

  @override
  factory RssItemModel.fromMap(Map<String, dynamic> map) {
    return RssItemModel(
      title: map['title'] as String,
      episode: map['episode'] as String,
      link: map['link'] as String,
      enclosureUrl: map['enclosureUrl'] as String,
      enclosureLength: map['enclosureLength'] as String,
      enclosureType: map['enclosureType'] as String,
      explicit: map['explicit'] as String,
      block: map['block'] as String,
      duration: map['duration'] as String,
    );
  }
}
