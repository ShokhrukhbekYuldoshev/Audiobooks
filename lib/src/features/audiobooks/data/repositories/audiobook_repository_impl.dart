import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:audiobooks/src/core/errors/exceptions.dart';
import 'package:audiobooks/src/core/errors/failures.dart';
import 'package:audiobooks/src/features/audiobooks/data/datasources/remote/audiobooks_remote_data_source.dart';
import 'package:audiobooks/src/features/audiobooks/data/models/audiobook_model.dart';
import 'package:audiobooks/src/features/audiobooks/domain/repositories/audiobook_repository.dart';

class AudiobookRepositoryImpl implements AudiobookRepository {
  final AudiobooksRemoteDataSource audiobookRemoteDatasource;

  AudiobookRepositoryImpl(this.audiobookRemoteDatasource);

  @override
  Future<Either<Failure, List<AudiobookModel>>> getAudiobooks() async {
    try {
      final result = await audiobookRemoteDatasource.getAudiobooks();
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
