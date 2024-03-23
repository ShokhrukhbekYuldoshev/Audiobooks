import 'package:audiobooks/src/core/themes/cubit/theme_cubit.dart';
import 'package:audiobooks/src/presentation/bloc/settings/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:audiobooks/src/app.dart';
import 'package:audiobooks/src/core/di/service_locator.dart';
import 'package:audiobooks/src/domain/repositories/just_audio_player.dart';
import 'package:audiobooks/src/presentation/bloc/home/home_bloc.dart';

// TODO: implement playlist (whole book) instead of single book chapter

Future<void> main() async {
  // Ensure that the Flutter binding has been initialized
  WidgetsFlutterBinding.ensureInitialized();

  // ask for notification permission if not granted
  if (!await Permission.notification.isGranted) {
    await Permission.notification.request();
  }

  // Plugin must be initialized before using
  await FlutterDownloader.initialize(
    // optional: set to false to disable printing logs to console (default: true)
    debug: true,

    // optional: set to false to disable working with http links (default: false)
    ignoreSsl: true,
  );

  // Initialize the service locator for dependency injection
  init();

  // initialize audio service
  await sl<JustAudioPlayer>().init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<HomeBloc>()..add(GetHomePageEvent()),
        ),
        BlocProvider(
          create: (context) => sl<ThemeCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<SettingsCubit>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
