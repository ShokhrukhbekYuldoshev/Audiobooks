import 'package:flutter/material.dart';

import 'package:audiobooks/src/core/di/service_locator.dart';
import 'package:audiobooks/src/core/router/app_router.dart';
import 'package:audiobooks/src/core/themes/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audiobooks',
      theme: sl<AppTheme>().lightTheme,
      darkTheme: sl<AppTheme>().darkTheme,
      onGenerateRoute: (settings) => sl<AppRouter>().generateRoute(settings),
    );
  }
}
