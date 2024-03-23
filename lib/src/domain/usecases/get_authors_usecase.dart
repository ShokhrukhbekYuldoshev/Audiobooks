import 'package:audiobooks/src/core/errors/failures.dart';
import 'package:audiobooks/src/core/usecases/no_params.dart';
import 'package:audiobooks/src/core/usecases/usecase.dart';
import 'package:audiobooks/src/domain/entities/author_entity.dart';
import 'package:audiobooks/src/domain/repositories/audiobook_repository.dart';
import 'package:dartz/dartz.dart';

class GetAuthorsUseCase extends UseCase<List<AuthorEntity>, NoParams> {
  final AudiobookRepository repository;

  GetAuthorsUseCase(this.repository);

  @override
  Future<Either<Failure, List<AuthorEntity>>> call(NoParams params) async {
    return await repository.getAuthors();
  }
}
