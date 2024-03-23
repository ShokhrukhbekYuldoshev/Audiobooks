import 'package:audiobooks/src/data/models/rss_model.dart';
import 'package:xml/xml.dart';

class RssFeedEntity {
  final RssChannelEntity channel;

  RssFeedEntity({required this.channel});

  factory RssFeedEntity.parse(String xmlString) {
    final document = XmlDocument.parse(xmlString);
    final channel = RssChannelEntity.parse(
        document.rootElement.findElements('channel').first);
    return RssFeedEntity(channel: channel);
  }

  // empty feed
  factory RssFeedEntity.empty() {
    return RssFeedEntity(
        channel: RssChannelEntity(
      title: '',
      link: '',
      description: '',
      language: '',
      itunesType: '',
      itunesAuthor: '',
      itunesSummary: '',
      itunesOwnerName: '',
      itunesOwnerEmail: '',
      itunesCategoryText: '',
      itunesCategoryText2: '',
      itunesImageHref: '',
      items: [],
    ));
  }

  RssFeedModel toModel() {
    return RssFeedModel(channel: channel.toModel());
  }
}

class RssChannelEntity {
  final String title;
  final String link;
  final String description;
  final String language;
  final String itunesType;
  final String itunesAuthor;
  final String itunesSummary;
  final String itunesOwnerName;
  final String itunesOwnerEmail;
  final String itunesCategoryText;
  final String itunesCategoryText2;
  final String itunesImageHref;
  final List<RssItemEntity> items;

  RssChannelEntity({
    required this.title,
    required this.link,
    required this.description,
    required this.language,
    required this.itunesType,
    required this.itunesAuthor,
    required this.itunesSummary,
    required this.itunesOwnerName,
    required this.itunesOwnerEmail,
    required this.itunesCategoryText,
    required this.itunesCategoryText2,
    required this.itunesImageHref,
    required this.items,
  });

  factory RssChannelEntity.parse(XmlElement element) {
    final title = element.findElements('title').first.innerText;
    final link = element.findElements('link').first.innerText;
    final description = element.findElements('description').first.innerText;
    final language = element.findElements('language').first.innerText;
    final itunesType = element.findElements('itunes:type').first.innerText;
    final itunesAuthor = element.findElements('itunes:author').first.innerText;
    final itunesSummary =
        element.findElements('itunes:summary').first.innerText;
    final itunesOwner = element.findElements('itunes:owner').first;
    final itunesOwnerName =
        itunesOwner.findElements('itunes:name').first.innerText;
    final itunesOwnerEmail =
        itunesOwner.findElements('itunes:email').first.innerText;
    final itunesCategory = element.findElements('itunes:category').first;
    final itunesCategoryText = itunesCategory.getAttribute('text')!;
    final itunesCategoryText2 = itunesCategory
        .findElements('itunes:category')
        .first
        .getAttribute('text')!;
    final itunesImageHref =
        element.findElements('itunes:image').first.getAttribute('href')!;
    final items = element
        .findElements('item')
        .map((e) => RssItemEntity.parse(e))
        .toList();
    return RssChannelEntity(
      title: title,
      link: link,
      description: description,
      language: language,
      itunesType: itunesType,
      itunesAuthor: itunesAuthor,
      itunesSummary: itunesSummary,
      itunesOwnerName: itunesOwnerName,
      itunesOwnerEmail: itunesOwnerEmail,
      itunesCategoryText: itunesCategoryText,
      itunesCategoryText2: itunesCategoryText2,
      itunesImageHref: itunesImageHref,
      items: items,
    );
  }

  RssChannelModel toModel() {
    return RssChannelModel(
      title: title,
      link: link,
      description: description,
      language: language,
      itunesType: itunesType,
      itunesAuthor: itunesAuthor,
      itunesSummary: itunesSummary,
      itunesOwnerName: itunesOwnerName,
      itunesOwnerEmail: itunesOwnerEmail,
      itunesCategoryText: itunesCategoryText,
      itunesCategoryText2: itunesCategoryText2,
      itunesImageHref: itunesImageHref,
      items: items.map((e) => e.toModel()).toList(),
    );
  }
}

class RssItemEntity {
  final String title;
  final String episode;
  final String link;
  final String enclosureUrl;
  final String enclosureLength;
  final String enclosureType;
  final String explicit;
  final String block;
  final String duration;

  RssItemEntity({
    required this.title,
    required this.episode,
    required this.link,
    required this.enclosureUrl,
    required this.enclosureLength,
    required this.enclosureType,
    required this.explicit,
    required this.block,
    required this.duration,
  });

  factory RssItemEntity.parse(XmlElement element) {
    final title = element.findElements('title').first.innerText;
    final episode = element.findElements('itunes:episode').first.innerText;
    final link = element.findElements('link').first.innerText;
    final enclosure = element.findElements('enclosure').first;
    final enclosureUrl = enclosure.getAttribute('url')!;
    final enclosureLength = enclosure.getAttribute('length')!;
    final enclosureType = enclosure.getAttribute('type')!;
    final explicit = element.findElements('itunes:explicit').first.innerText;
    final block = element.findElements('itunes:block').first.innerText;
    final duration =
        element.findElements('itunes:duration').first.innerText.trim();
    return RssItemEntity(
      title: title,
      episode: episode,
      link: link,
      enclosureUrl: enclosureUrl,
      enclosureLength: enclosureLength,
      enclosureType: enclosureType,
      explicit: explicit,
      block: block,
      duration: duration,
    );
  }

  RssItemModel toModel() {
    return RssItemModel(
      title: title,
      episode: episode,
      link: link,
      enclosureUrl: enclosureUrl,
      enclosureLength: enclosureLength,
      enclosureType: enclosureType,
      explicit: explicit,
      block: block,
      duration: duration,
    );
  }
}
