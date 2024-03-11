import 'package:audiobooks/src/features/audiobooks/domain/entities/audiobook_entity.dart';
import 'package:audiobooks/src/features/audiobooks/presentation/pages/audiobook_details_page.dart';
import 'package:audiobooks/src/features/audiobooks/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String homeRoute = '/';
  static const String audiobookDetailsRoute = '/audiobook-details';

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
