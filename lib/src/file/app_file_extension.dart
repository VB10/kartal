import 'package:kartal/src/constants/file_constants.dart';
import 'package:kartal/src/file/file_type.dart';
import 'package:kartal/src/private/file/app_file_extension.dart'
    if (dart.library.html) 'package:kartal/src/private/file/web_file_extension.dart'
    as custom_file;
import 'package:mime/mime.dart';

/// Extension methods for [custom_file.File] to determine the type of the file.
extension FileTypeExtension on custom_file.File {
  _FileExtension get ext => _FileExtension(this);
}

/// Provides convenient access to determine the type of a file and check
/// if it belongs to specific types.

final class _FileExtension {
  const _FileExtension(custom_file.File file) : _file = file;
  final custom_file.File _file;

  /// Returns the [FileType] of the file based on its MIME type.
  FileType get fileType {
    final mimeType = lookupMimeType(_file.pathName);
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
