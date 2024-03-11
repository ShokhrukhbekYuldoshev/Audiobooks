import 'package:audiobooks/src/core/errors/failures.dart';
import 'package:audiobooks/src/core/usecases/no_params.dart';
import 'package:audiobooks/src/core/usecases/usecase.dart';
import 'package:audiobooks/src/features/audiobooks/domain/entities/audiobook_entity.dart';
import 'package:audiobooks/src/features/audiobooks/domain/repositories/audiobook_repository.dart';
import 'package:dartz/dartz.dart';

class GetAudiobooksUseCase extends UseCase<List<AudiobookEntity>, NoParams> {
  final AudiobookRepository repository;

  GetAudiobooksUseCase(this.repository);

  @override
  Future<Either<Failure, List<AudiobookEntity>>> call(NoParams params) async {
    return await repository.getAudiobooks();
  }
}
