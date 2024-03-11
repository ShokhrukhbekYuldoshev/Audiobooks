import 'package:audiobooks/src/app.dart';
import 'package:audiobooks/src/core/di/service_locator.dart';
import 'package:audiobooks/src/features/audiobooks/presentation/bloc/audiobooks_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  // Ensure that the Flutter binding has been initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the service locator for dependency injection
  init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AudiobooksBloc>()..add(GetAudiobooksEvent()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
