import 'package:audiobooks/src/core/network/network_info.dart';
import 'package:audiobooks/src/data/datasources/local/audiobooks_local_data_source.dart';
import 'package:audiobooks/src/data/models/author_model.dart';
import 'package:dartz/dartz.dart';

import 'package:audiobooks/src/core/errors/exceptions.dart';
import 'package:audiobooks/src/core/errors/failures.dart';
import 'package:audiobooks/src/data/datasources/remote/audiobooks_remote_data_source.dart';
import 'package:audiobooks/src/data/models/audiobook_model.dart';
import 'package:audiobooks/src/domain/repositories/audiobook_repository.dart';

class AudiobookRepositoryImpl implements AudiobookRepository {
  final AudiobooksRemoteDataSource audiobookRemoteDatasource;
  final AudiobooksLocalDataSource audiobooksLocalDataSource;
  final NetworkInfo networkInfo;

  AudiobookRepositoryImpl(
    this.audiobookRemoteDatasource,
    this.audiobooksLocalDataSource,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, List<AudiobookModel>>> getAudiobooks() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAudiobooks =
            await audiobookRemoteDatasource.getAudiobooks();
        await audiobooksLocalDataSource.saveAudiobooks(remoteAudiobooks);
        return Right(remoteAudiobooks);
      } on ServerException {
        return const Left(ServerFailure("An error has occurred"));
      }
    } else {
      try {
        final localAudiobooks = await audiobooksLocalDataSource.getAudiobooks();
        return Right(localAudiobooks);
      } on Exception {
        return const Left(DatabaseFailure("No Internet Connection"));
      }
    }
  }

  @override
  Future<Either<Failure, List<AuthorModel>>> getAuthors() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAuthors = await audiobookRemoteDatasource.getAuthors();
        await audiobooksLocalDataSource.saveAuthors(remoteAuthors);
        return Right(remoteAuthors);
      } on ServerException {
        return const Left(ServerFailure("An error has occurred"));
      }
    } else {
      try {
        final localAuthors = await audiobooksLocalDataSource.getAuthors();
        return Right(localAuthors);
      } on Exception {
        return const Left(DatabaseFailure("No Internet Connection"));
      }
    }
  }
}
