import 'dart:io' if (dart.library.js_interop) 'package:web/web.dart' show File;

import 'package:kartal/src/constants/file_constants.dart';
import 'package:kartal/src/file/file_type.dart';
import 'package:kartal/src/private/file/app_file_extension.dart'
    if (dart.library.js_interop) 'package:kartal/src/private/file/web_file_extension.dart';
import 'package:mime/mime.dart';

/// Extension methods for [File] to determine the type of the file.
extension FileTypeExtension on File {
  _FileExtension get ext => _FileExtension(this);
}

/// Provides convenient access to determine the type of a file and check
/// if it belongs to specific types.

final class _FileExtension {
  _FileExtension(File file) : _file = file;
  final File _file;

  /// Returns the [FileType] of the file based on its MIME type.
  FileType get fileType {
    final mimeType = lookupMimeType(_file.pathName);
    if (mimeType?.startsWith(FileConstants.instance().imageType) ?? false) {
      return FileType.image;
    }
    if (mimeType?.startsWith(FileConstants.instance().videoType) ?? false) {
      return FileType.video;
    }
    if (mimeType?.startsWith(FileConstants.instance().audioType) ?? false) {
      return FileType.audio;
    }
    if (mimeType?.startsWith(FileConstants.instance().textType) ?? false) {
      return FileType.text;
    }
    return FileType.unknown;
  }

  /// Returns `true` if the file is of type [FileType.image].
  bool get isImageFile => fileType == FileType.image;

  /// Returns `true` if the file is of type [FileType.video].
  bool get isVideoFile => fileType == FileType.video;

  /// Returns `true` if the file is of type [FileType.audio].
  bool get isAudioFile => fileType == FileType.audio;

  /// Returns `true` if the file is of type [FileType.text].
  bool get isTextFile => fileType == FileType.text;
}
