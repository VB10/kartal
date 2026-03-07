import 'package:web/web.dart' as web;

export 'package:web/web.dart' show File;

/// Using for web:File
extension FileExtension on web.File {
  String get pathName => name;
}
