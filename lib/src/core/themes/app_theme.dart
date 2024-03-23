import 'package:audiobooks/src/core/themes/color_schemes.g.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme {
  ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme,
      sliderTheme: SliderThemeData(
        trackHeight: 2.0,
        inactiveTrackColor: lightColorScheme.onSurface.withOpacity(0.5),
        activeTrackColor: lightColorScheme.primary,
        thumbShape: const RoundSliderThumbShape(
          enabledThumbRadius: 6.0,
        ),
        overlayShape: const RoundSliderOverlayShape(
          overlayRadius: 12.0,
        ),
      ),
    );
  }

  ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      sliderTheme: SliderThemeData(
        trackHeight: 2.0,
        inactiveTrackColor: darkColorScheme.onSurface.withOpacity(0.5),
        activeTrackColor: darkColorScheme.primary,
        thumbShape: const RoundSliderThumbShape(
          enabledThumbRadius: 6.0,
        ),
        overlayShape: const RoundSliderOverlayShape(
          overlayRadius: 12.0,
        ),
      ),
    );
  }

  Future<ThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('themeMode') ?? 'system';
    if (theme == 'light') {
      return ThemeMode.light;
    } else if (theme == 'dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }
}
