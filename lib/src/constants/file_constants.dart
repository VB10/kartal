class FileConstants {
  FileConstants._init();
  factory FileConstants.instance() => _instance ??= FileConstants._init();
  static FileConstants? _instance;

  final imageType = 'image/';
  final videoType = 'video/';
  final audioType = 'audio/';
  final textType = 'text/';
}
