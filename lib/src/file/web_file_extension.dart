import 'package:kartal/src/constants/file_constants.dart';
import 'package:kartal/src/file/file_type.dart';
import 'package:mime/mime.dart';
import 'package:web/web.dart' if (dart.library.io) 'dart:io' show File;

extension WebFileTypeExtension on File {
  _FileExtension get ext => _FileExtension(this);
}

final class _FileExtension {
  _FileExtension(File file) : _file = file;
  final File _file;

  String get pathName {
    try {
      return (_file as dynamic).name as String;
    } on Exception catch (_) {
      return (_file as dynamic).path as String;
    }
  }

  FileType get fileType {
    final mimeType = lookupMimeType(pathName);
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

  bool get isImageFile => fileType == FileType.image;
  bool get isVideoFile => fileType == FileType.video;
  bool get isAudioFile => fileType == FileType.audio;
  bool get isTextFile => fileType == FileType.text;
}
