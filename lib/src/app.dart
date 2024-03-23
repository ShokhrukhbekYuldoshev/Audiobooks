import 'package:audiobooks/src/core/themes/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';

import 'package:audiobooks/src/core/di/service_locator.dart';
import 'package:audiobooks/src/core/router/app_router.dart';
import 'package:audiobooks/src/core/themes/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return FutureBuilder(
          future: sl<AppTheme>().getThemeMode(),
          builder: (_, snapshot) {
            ThemeMode themeMode = ThemeMode.system;

            if (snapshot.hasData) {
              themeMode = snapshot.data as ThemeMode;
            }

            return MaterialApp(
              title: 'Audiobooks',
              themeMode: themeMode,
              theme: sl<AppTheme>().lightTheme,
              darkTheme: sl<AppTheme>().darkTheme,
              onGenerateRoute: (settings) => sl<AppRouter>().generateRoute(
                settings,
              ),
            );
          },
        );
      },
    );
  }
}
