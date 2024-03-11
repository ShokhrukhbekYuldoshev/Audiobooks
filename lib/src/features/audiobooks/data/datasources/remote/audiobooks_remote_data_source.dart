import 'package:audiobooks/src/core/constants/api.dart';
import 'package:audiobooks/src/core/errors/exceptions.dart';
import 'package:audiobooks/src/core/network/network_service.dart';
import 'package:audiobooks/src/features/audiobooks/data/models/audiobook_model.dart';

class AudiobooksRemoteDataSource {
  final NetworkService networkService;

  AudiobooksRemoteDataSource({required this.networkService});

  Future<List<AudiobookModel>> getAudiobooks() async {
    final response = await networkService.getRequest(
      LibrivoxApiEndpoints.getAudiobooksUrl(),
    );

    if (response.statusCode == 200) {
      final audiobooks = response.data['books'] as List;
      return audiobooks
          .map((audiobook) => AudiobookModel.fromMap(audiobook))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
