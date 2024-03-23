import 'package:equatable/equatable.dart';

import 'package:audiobooks/src/data/models/audiobook_model.dart';
import 'package:audiobooks/src/domain/entities/author_entity.dart';
import 'package:audiobooks/src/domain/entities/rss_entity.dart';

// ignore: must_be_immutable
class AudiobookEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String urlTextSource; // url to the text source (gutenberg, etc.)
  final String language;
  final String copyrightYear;
  final String numSections; // number of sections
  final String urlRss; // url to the rss feed (really simple syndication)
  final String urlZipFile;
  final String urlProject; // url to the project page (wikipedia, etc.)
  final String
      urlLibrivox; // url to the librivox page (a free public domain audiobook library)
  final String urlOther;
  final String totaltime; // total time in hh:mm:ss
  final int totaltimesecs; // total time in seconds
  final List<AuthorEntity> authors;

  RssFeedEntity? rssFeed;

  AudiobookEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.urlTextSource,
    required this.language,
    required this.copyrightYear,
    required this.numSections,
    required this.urlRss,
    required this.urlZipFile,
    required this.urlProject,
    required this.urlLibrivox,
    required this.urlOther,
    required this.totaltime,
    required this.totaltimesecs,
    required this.authors,
    this.rssFeed,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        urlTextSource,
        language,
        copyrightYear,
        numSections,
        urlRss,
        urlZipFile,
        urlProject,
        urlLibrivox,
        urlOther,
        totaltime,
        totaltimesecs,
        authors,
        rssFeed,
      ];

  AudiobookModel toModel() {
    return AudiobookModel(
      id: id,
      title: title,
      description: description,
      urlTextSource: urlTextSource,
      language: language,
      copyrightYear: copyrightYear,
      numSections: numSections,
      urlRss: urlRss,
      urlZipFile: urlZipFile,
      urlProject: urlProject,
      urlLibrivox: urlLibrivox,
      urlOther: urlOther,
      totaltime: totaltime,
      totaltimesecs: totaltimesecs,
      authors: authors,
      rssFeed: rssFeed,
    );
  }

  AudiobookEntity copyWith({
    String? id,
    String? title,
    String? description,
    String? urlTextSource,
    String? language,
    String? copyrightYear,
    String? numSections,
    String? urlRss,
    String? urlZipFile,
    String? urlProject,
    //? urlLibrivox,
    String? urlOther,
    String? totaltime,
    int? totaltimesecs,
    List<AuthorEntity>? authors,
    RssFeedEntity? rssFeed,
  }) {
    return AudiobookEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      urlTextSource: urlTextSource ?? this.urlTextSource,
      language: language ?? this.language,
      copyrightYear: copyrightYear ?? this.copyrightYear,
      numSections: numSections ?? this.numSections,
      urlRss: urlRss ?? this.urlRss,
      urlZipFile: urlZipFile ?? this.urlZipFile,
      urlProject: urlProject ?? this.urlProject,
      urlLibrivox: urlLibrivox,
      urlOther: urlOther ?? this.urlOther,
      totaltime: totaltime ?? this.totaltime,
      totaltimesecs: totaltimesecs ?? this.totaltimesecs,
      authors: authors ?? this.authors,
      rssFeed: rssFeed ?? this.rssFeed,
    );
  }
}
