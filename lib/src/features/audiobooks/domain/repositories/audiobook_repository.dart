import 'package:audiobooks/src/core/errors/failures.dart';
import 'package:audiobooks/src/features/audiobooks/domain/entities/audiobook_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AudiobookRepository {
  Future<Either<Failure, List<AudiobookEntity>>> getAudiobooks();
}
