import 'package:audiobooks/src/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'package:audiobooks/src/domain/entities/audiobook_entity.dart';
import 'package:audiobooks/src/presentation/pages/audiobook_details_page.dart';
import 'package:audiobooks/src/presentation/pages/home_page.dart';
import 'package:audiobooks/src/presentation/pages/player_page.dart';

class AppRouter {
  static const String homeRoute = '/';
  static const String audiobookDetailsRoute = '/audiobook-details';
  static const String playerRoute = '/player';
  static const String settingsRoute = '/settings';

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case audiobookDetailsRoute:
        return MaterialPageRoute(
          builder: (_) => AudiobookDetailsPage(
            audiobook: settings.arguments as AudiobookEntity,
          ),
        );
      case playerRoute:
        return MaterialPageRoute(
          builder: (_) => PlayerPage(
            source: settings.arguments as ProgressiveAudioSource,
          ),
        );
      case settingsRoute:
        return MaterialPageRoute(
          builder: (_) => const SettingsPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
