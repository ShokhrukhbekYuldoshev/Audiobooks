import 'package:audiobooks/src/core/constants/api.dart';
import 'package:audiobooks/src/core/errors/exceptions.dart';
import 'package:audiobooks/src/core/network/network_service.dart';
import 'package:audiobooks/src/data/models/audiobook_model.dart';
import 'package:audiobooks/src/data/models/author_model.dart';
import 'package:audiobooks/src/domain/entities/rss_entity.dart';

class AudiobooksRemoteDataSource {
  final NetworkService networkService;

  AudiobooksRemoteDataSource({required this.networkService});

  Future<RssFeedEntity> getAudiobookDetails(String urlRss) async {
    final response = await networkService.getRequest(
      urlRss,
    );

    if (response.statusCode == 200) {
      return RssFeedEntity.parse(response.data);
    } else {
      throw ServerException();
    }
  }

  Future<List<AudiobookModel>> getAudiobooks() async {
    final response = await networkService.getRequest(
      LibrivoxApiEndpoints.getAudiobooksUrl(),
    );

    if (response.statusCode == 200) {
      final audiobooks = response.data['books'] as List;
      // convert to model
      List<AudiobookModel> models = audiobooks
          .map((audiobook) => AudiobookModel.fromMap(audiobook))
          .toList();

      // get details
      for (var audiobook in models) {
        final details = await getAudiobookDetails(audiobook.urlRss);
        audiobook.rssFeed = details;
      }

      return models;
    } else {
      throw ServerException();
    }
  }

  Future<List<AuthorModel>> getAuthors() async {
    final response = await networkService.getRequest(
      LibrivoxApiEndpoints.getAuthorsUrl(),
    );

    if (response.statusCode == 200) {
      final authors = response.data['authors'] as List;
      return authors.map((author) => AuthorModel.fromMap(author)).toList();
    } else {
      throw ServerException();
    }
  }
}
