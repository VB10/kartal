import 'dart:io';

export 'dart:io' show File;

/// Using for io:File
extension FileExtension on File {
  String get pathName => path;
}
