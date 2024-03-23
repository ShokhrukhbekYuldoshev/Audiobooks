import 'package:audiobooks/src/core/errors/failures.dart';
import 'package:audiobooks/src/domain/entities/audiobook_entity.dart';
import 'package:audiobooks/src/domain/entities/author_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AudiobookRepository {
  /// Get a list of all audiobooks.
  Future<Either<Failure, List<AudiobookEntity>>> getAudiobooks();

  /// Get a list of all authors.
  Future<Either<Failure, List<AuthorEntity>>> getAuthors();
}
