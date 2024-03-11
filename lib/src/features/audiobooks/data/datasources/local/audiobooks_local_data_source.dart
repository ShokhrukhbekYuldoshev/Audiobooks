import 'package:audiobooks/src/features/audiobooks/data/models/audiobook_model.dart';

abstract class AudiobooksLocalDataSource {
  Future<List<AudiobookModel>> getAudiobooks();
}

// TODO: Implement the local data source
class AudiobooksLocalDataSourceImpl implements AudiobooksLocalDataSource {
  @override
  Future<List<AudiobookModel>> getAudiobooks() {
    throw UnimplementedError();
  }
}
