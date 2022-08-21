class FileConstants {
  FileConstants._init();
  static FileConstants? _instance;
  static FileConstants get instance {
    if (_instance != null) {
      return _instance!;
    }

    _instance = FileConstants._init();
    return _instance!;
  }

  final imageType = 'image/';
  final videoType = 'video/';
  final audioType = 'audio/';
  final textType = 'text/';
}
