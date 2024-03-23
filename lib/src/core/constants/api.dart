class LibrivoxApiUrls {
  static const String baseUrl = 'https://librivox.org/api/feed';

  static const String audiobooksFeed =
      '$baseUrl/audiobooks?limit=5&format=json';
  static const String authorsFeed = '$baseUrl/authors?format=json';
}

class LibrivoxApiEndpoints {
  // Audiobooks
  static String getAudiobooksUrl() => LibrivoxApiUrls.audiobooksFeed;
  static String getAudiobookUrlById(int audiobookId) =>
      '${LibrivoxApiUrls.audiobooksFeed}/?id=$audiobookId?format=json';
  static String getAudiobooksUrlByTitle(String title) =>
      '${LibrivoxApiUrls.audiobooksFeed}/title/^$title?format=json';

  // Authors
  static String getAuthorsUrl() => LibrivoxApiUrls.authorsFeed;
  static String getAuthorUrlById(int authorId) =>
      '${LibrivoxApiUrls.authorsFeed}/?id=$authorId?format=json';
}
