import 'package:audiobooks/src/data/datasources/local/db_service.dart';
import 'package:audiobooks/src/data/models/audiobook_model.dart';
import 'package:audiobooks/src/data/models/author_model.dart';

class AudiobooksLocalDataSource {
  final DatabaseService databaseService;

  AudiobooksLocalDataSource({required this.databaseService});

  Future<List<AudiobookModel>> getAudiobooks() async {
    final audiobooks = await databaseService.getAll('audiobooks');
    return audiobooks.map((e) => AudiobookModel.fromDatabase(e)).toList();
  }

  Future<List<AuthorModel>> getAuthors() async {
    final authors = await databaseService.getAll('authors');
    return authors.map((e) => AuthorModel.fromMap(e)).toList();
  }

  Future<void> saveAudiobooks(List<AudiobookModel> audiobooks) async {
    for (final audiobook in audiobooks) {
      await databaseService.insert('audiobooks', audiobook.toDatabase());
    }
  }

  Future<void> saveAuthors(List<AuthorModel> authors) async {
    for (final author in authors) {
      await databaseService.insert('authors', author.toMap());
    }
  }

  Future<void> clearDatabase() async {
    await databaseService.deleteAll('audiobooks');
    await databaseService.deleteAll('authors');
  }
}
