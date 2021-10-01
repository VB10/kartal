class FileConstants {
  static FileConstants? _instace;
  static FileConstants get instance {
    if (_instace != null) {
      return _instace!;
    }

    _instace = FileConstants._init();
    return _instace!;
  }

  FileConstants._init();

  final imageType = 'image/';
  final videoType = 'video/';
  final audioType = 'audio/';
  final textType = 'text/';
}
