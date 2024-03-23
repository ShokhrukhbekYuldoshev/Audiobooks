import 'dart:convert';

import 'package:audiobooks/src/data/models/author_model.dart';
import 'package:audiobooks/src/data/models/rss_model.dart';
import 'package:audiobooks/src/domain/entities/audiobook_entity.dart';

// ignore: must_be_immutable
class AudiobookModel extends AudiobookEntity {
  AudiobookModel({
    required super.id,
    required super.title,
    required super.description,
    required super.urlTextSource,
    required super.language,
    required super.copyrightYear,
    required super.numSections,
    required super.urlRss,
    required super.urlZipFile,
    required super.urlProject,
    required super.urlLibrivox,
    required super.urlOther,
    required super.totaltime,
    required super.totaltimesecs,
    required super.authors,
    required super.rssFeed,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'url_text_source': urlTextSource,
      'language': language,
      'copyright_year': copyrightYear,
      'num_sections': numSections,
      'url_rss': urlRss,
      'url_zip_file': urlZipFile,
      'url_project': urlProject,
      'url_librivox': urlLibrivox,
      'url_other': urlOther,
      'totaltime': totaltime,
      'totaltimesecs': totaltimesecs,
      'authors': authors.map((x) => x.toModel().toMap()).toList(),
      'rssFeed': rssFeed?.toModel().toMap(),
    };
  }

  @override
  factory AudiobookModel.fromMap(Map<String, dynamic> map) {
    return AudiobookModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      urlTextSource: map['url_text_source'] as String,
      language: map['language'] as String,
      copyrightYear: map['copyright_year'] as String,
      numSections: map['num_sections'] as String,
      urlRss: map['url_rss'] as String,
      urlZipFile: map['url_zip_file'] as String,
      urlProject: map['url_project'] as String,
      urlLibrivox: map['url_librivox'] as String,
      urlOther: map['url_other'] as String,
      totaltime: map['totaltime'] as String,
      totaltimesecs: map['totaltimesecs'] as int,
      authors: List<AuthorModel>.from(
        (map['authors'] as List).map<AuthorModel>(
          (x) => AuthorModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      rssFeed: map['rssFeed'] != null
          ? RssFeedModel.fromMap(map['rssFeed'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AudiobookModel.fromJson(String source) =>
      AudiobookModel.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toDatabase() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'url_text_source': urlTextSource,
      'language': language,
      'copyright_year': copyrightYear,
      'num_sections': numSections,
      'url_rss': urlRss,
      'url_zip_file': urlZipFile,
      'url_project': urlProject,
      'url_librivox': urlLibrivox,
      'url_other': urlOther,
      'totaltime': totaltime,
      'totaltimesecs': totaltimesecs,
      'authors': jsonEncode(authors.map((e) => e.toModel().toMap()).toList()),
      'rssFeed': jsonEncode(rssFeed?.toModel().toMap()),
    };
  }

  factory AudiobookModel.fromDatabase(Map<String, dynamic> map) {
    return AudiobookModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      urlTextSource: map['url_text_source'] as String,
      language: map['language'] as String,
      copyrightYear: map['copyright_year'] as String,
      numSections: map['num_sections'] as String,
      urlRss: map['url_rss'] as String,
      urlZipFile: map['url_zip_file'] as String,
      urlProject: map['url_project'] as String,
      urlLibrivox: map['url_librivox'] as String,
      urlOther: map['url_other'] as String,
      totaltime: map['totaltime'] as String,
      totaltimesecs: map['totaltimesecs'] as int,
      authors: List<AuthorModel>.from(
        jsonDecode(map['authors'] as String).map(
          (e) => AuthorModel.fromMap(e as Map<String, dynamic>),
        ),
      ),
      rssFeed: RssFeedModel.fromMap(
        jsonDecode(map['rssFeed'] as String) as Map<String, dynamic>,
      ),
    );
  }

  AudiobookEntity toEntity() {
    return AudiobookEntity(
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
    );
  }
}
