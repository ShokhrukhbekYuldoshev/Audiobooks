import 'package:audiobooks/src/core/themes/cubit/theme_cubit.dart';
import 'package:audiobooks/src/presentation/bloc/settings/settings_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';

import 'package:audiobooks/src/core/constants/api.dart';
import 'package:audiobooks/src/core/constants/assets.dart';
import 'package:audiobooks/src/core/helpers/input_converter.dart';
import 'package:audiobooks/src/core/network/network_service.dart';
import 'package:audiobooks/src/data/datasources/local/audiobooks_local_data_source.dart';
import 'package:audiobooks/src/data/datasources/local/db_service.dart';
import 'package:audiobooks/src/data/datasources/remote/audiobooks_remote_data_source.dart';
import 'package:audiobooks/src/data/repositories/audiobook_repository_impl.dart';
import 'package:audiobooks/src/domain/repositories/audiobook_repository.dart';
import 'package:audiobooks/src/domain/repositories/just_audio_player.dart';
import 'package:audiobooks/src/domain/usecases/get_audiobooks_usecase.dart';
import 'package:audiobooks/src/domain/usecases/get_authors_usecase.dart';
import 'package:audiobooks/src/presentation/bloc/home/home_bloc.dart';

import '../errors/failures.dart';
import '../network/network_info.dart';
import '../router/app_router.dart';
import '../themes/app_theme.dart';

/// get_it service locator for dependency injection in the app (https://pub.dev/packages/get_it)
final sl = GetIt.instance;

void init() {
  // ================================================================
  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => NetworkService(sl()));
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => AppRouter());
  sl.registerLazySingleton(() => AppTheme());
  sl.registerLazySingleton(() => Assets());
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton(() => LibrivoxApiUrls());
  sl.registerLazySingleton(() => LibrivoxApiEndpoints());

  // Errors
  sl.registerLazySingleton(
    () => const ServerFailure('An error has occurred'),
  );
  sl.registerLazySingleton(
    () => const ConnectionFailure('Failed to connect to the network'),
  );
  sl.registerLazySingleton(
    () => const DatabaseFailure('An error has occurred'),
  );
  sl.registerLazySingleton(
    () => const InvalidInputFailure(),
  );

  // Data sources
  sl.registerLazySingleton(
    () => AudiobooksRemoteDataSource(networkService: sl()),
  );
  sl.registerLazySingleton(
    () => AudiobooksLocalDataSource(
      databaseService: DatabaseService.instance,
    ),
  );

  // Repositories
  sl.registerLazySingleton<AudiobookRepository>(
    () => AudiobookRepositoryImpl(
      sl(),
      sl(),
      sl(),
    ),
  );
  sl.registerLazySingleton<JustAudioPlayer>(
    () => JustAudioPlayerImpl(),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAudiobooksUseCase(sl()));
  sl.registerLazySingleton(() => GetAuthorsUseCase(sl()));

  // Bloc
  sl.registerFactory(
    () => HomeBloc(
      getAudiobooksUseCase: sl(),
      getAuthorsUseCase: sl(),
    ),
  );
  // Cubit
  sl.registerFactory(() => ThemeCubit());
  sl.registerFactory(() => SettingsCubit());
}
