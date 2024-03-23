# 🎧📕 Audiobooks

Listen to your favorite audiobooks for free! Immerse yourself in the world of audiobooks with our app, built on Clean Architecture principles. Enjoy a vast selection of audiobooks, all while benefiting from a scalable, maintainable, and future-proof app structure.

NOTE: This app is still in development. iOS version may not work as expected.

## 📱 Platforms

-   Android
-   iOS

## ✨ Features

-   [x] Audio playback online
-   [x] Download audiobooks
-   [x] Play downloaded audiobooks
-   [x] Delete downloaded audiobooks
-   [x] Background audio
-   [x] Notification controls
-   [x] Lock screen controls
-   [x] Play, pause, skip, previous, seek, rewind
-   [x] Shuffle and repeat
-   [ ] Search for audiobooks
-   [x] Playlists (whole book)
-   [ ] Favorites
-   [ ] Sleep timer
-   [x] Settings
-   [x] Themes (Dark, Light, System)

## 📸 Screenshots

<!-- Variables -->

[home-light]: screenshots/home-light.jpg 'Light theme'
[home-dark]: screenshots/home-dark.jpg 'Dark theme'
[audiobook-details]: screenshots/audiobook-details.jpg 'Audiobook details'
[audiobook-details-scroll]: screenshots/audiobook-details-scroll.jpg 'Audiobook details scroll'
[player]: screenshots/player.jpg 'Player'
[settings]: screenshots/settings.jpg 'Settings'

<!-- Table -->

|        Light theme        |       Dark theme        | Audiobook details                       |
| :-----------------------: | :---------------------: | --------------------------------------- |
| ![home-light][home-light] | ![home-dark][home-dark] | ![audiobook-details][audiobook-details] |

| Audiobook details scroll                              | Player            | Settings              |
| ----------------------------------------------------- | ----------------- | --------------------- |
| ![audiobook-details-scroll][audiobook-details-scroll] | ![player][player] | ![settings][settings] |

## 📚 Dependencies

| Name                                                                          | Version       | Description                                                                                                                                     |
| ----------------------------------------------------------------------------- | ------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| [connectivity_plus](https://pub.dev/packages/connectivity_plus)               | 6.0.1         | A Flutter plugin for discovering network connectivity configurations: Wi-Fi, mobile, etc.                                                       |
| [dio](https://pub.dev/packages/dio)                                           | 5.4.1         | A powerful package for Dart, which supports Interceptors, Global configuration, FormData, Request Cancellation, File downloading, Timeout, etc. |
| [get_it](https://pub.dev/packages/get_it)                                     | 7.6.7         | Simple service locator for Dart and Flutter projects and works with all kinds of objects: singletons, factories, lazy singletons, etc.          |
| [bloc](https://pub.dev/packages/bloc)                                         | 8.1.3         | A predictable state management library                                                                                                          |
| [flutter_bloc](https://pub.dev/packages/flutter_bloc)                         | 8.1.4         | Flutter widgets that require a Bloc to function                                                                                                 |
| [equatable](https://pub.dev/packages/equatable)                               | 2.0.5         | A Dart package that helps to simplify equality comparisons.                                                                                     |
| [dartz](https://pub.dev/packages/dartz)                                       | 0.10.1        | A Dart functional programming library inspired by Haskell.                                                                                      |
| [flutter_widget_from_html](https://pub.dev/packages/flutter_widget_from_html) | 0.14.11       | A Flutter package to render widgets from HTML strings.                                                                                          |
| [cached_network_image](https://pub.dev/packages/cached_network_image)         | 3.3.1         | A Flutter library to show images from the internet and keep them in the cache directory.                                                        |
| [xml](https://pub.dev/packages/xml)                                           | 6.5.0         | A Dart XML parser and serializer.                                                                                                               |
| [url_launcher](https://pub.dev/packages/url_launcher)                         | 6.2.5         | A Flutter plugin for launching URLs in mobile applications.                                                                                     |
| [shimmer](https://pub.dev/packages/shimmer)                                   | 3.0.0         | A Flutter package that provides an easy way to add shimmer effect to your Flutter app.                                                          |
| [just_audio](https://pub.dev/packages/just_audio)                             | 0.9.36        | A Flutter plugin for playing audio.                                                                                                             |
| [just_audio_background](https://pub.dev/packages/just_audio_background)       | 0.0.1-beta.11 | A Flutter plugin for playing audio in the background.                                                                                           |
| [path](https://pub.dev/packages/path)                                         | 1.9.0         | A Dart package for manipulating file paths.                                                                                                     |
| [path_provider](https://pub.dev/packages/path_provider)                       | 2.1.2         | A Flutter plugin for finding commonly used locations on the filesystem.                                                                         |
| [flutter_downloader](https://pub.dev/packages/flutter_downloader)             | 1.11.6        | A Flutter plugin for downloading files directly to the device's storage.                                                                        |
| [sqflite](https://pub.dev/packages/sqflite)                                   | 2.3.2         | A Flutter plugin for SQLite, a self-contained, high-reliability, embedded, SQL database engine.                                                 |
| [package_info_plus](https://pub.dev/packages/package_info_plus)               | 4.2.0         | A Flutter plugin for querying information about the application package.                                                                        |
| [permission_handler](https://pub.dev/packages/permission_handler)             | 11.3.0        | A Flutter plugin for requesting and checking permissions.                                                                                       |
| [shared_preferences](https://pub.dev/packages/shared_preferences)             | 2.2.2         | A Flutter plugin for reading and writing simple key-value pairs.                                                                                |

## 📦 Installation

### Prerequisites

-   Flutter
-   Android Studio / Xcode

### Setup

1. Clone the repo

    ```sh
    git clone
    ```

2. Install dependencies

    ```sh
    dart pub get
    ```

3. Run the app

    ```sh
    flutter run
    ```

## ❗ Permissions

### Android

```xml

<!-- url_launcher -->
<queries>
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="https" />
    </intent>
</queries>

<!-- Internet permission -->
<uses-permission android:name="android.permission.INTERNET" />

<!-- Android 13+ notification -->
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />

<!-- Audio service -->
<uses-permission android:name="android.permission.WAKE_LOCK" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
```

### iOS

```xml
<!-- url_launcher -->
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>https</string>
</array>
<key>UIBackgroundModes</key>
<array>
    <string>audio</string>
</array>
```

## 🤝 Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## 📝 License

Distributed under the MIT License. See [LICENSE](LICENSE) for more information.

## 📧 Contact

-   [Email](mailto:shokhrukhbekdev@gmail.com)
-   [GitHub](https://github.com/ShokhrukhbekYuldoshev)

## 🌟 Show your support

Give a ⭐️ if you like this project!
