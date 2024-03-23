import 'dart:io' if (dart.library.html) 'dart:html' show File;

import 'package:kartal/src/constants/file_constants.dart';
import 'package:mime/mime.dart';

extension FileTypeExtension on File {
  _FileExtension get ext => _FileExtension(this);
}

// ignore: constant_identifier_names
enum FileType { IMAGE, VIDEO, AUDIO, TEXT, UNKNOWN }

/// Provides convenient access to determine the type of a file and check
/// if it belongs to specific types.

final class _FileExtension {
  _FileExtension(File file) : _file = file;
  final File _file;

  /// Returns the [FileType] of the file based on its MIME type.
  FileType get fileType {
    final mimeType = lookupMimeType(_file.path);
    if (mimeType?.startsWith(FileConstants.instance().imageType) ?? false) {
      return FileType.IMAGE;
    }
    if (mimeType?.startsWith(FileConstants.instance().videoType) ?? false) {
      return FileType.VIDEO;
    }
    if (mimeType?.startsWith(FileConstants.instance().audioType) ?? false) {
      return FileType.AUDIO;
    }
    if (mimeType?.startsWith(FileConstants.instance().textType) ?? false) {
      return FileType.TEXT;
    }
    return FileType.UNKNOWN;
  }

  /// Returns `true` if the file is of type [FileType.IMAGE].
  bool get isImageFile => fileType == FileType.IMAGE;

  /// Returns `true` if the file is of type [FileType.VIDEO].
  bool get isVideoFile => fileType == FileType.VIDEO;

  /// Returns `true` if the file is of type [FileType.AUDIO].
  bool get isAudioFile => fileType == FileType.AUDIO;

  /// Returns `true` if the file is of type [FileType.TEXT].
  bool get isTextFile => fileType == FileType.TEXT;
}
