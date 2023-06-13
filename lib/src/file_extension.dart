import 'dart:io';

import 'package:kartal/src/constants/file_constants.dart';
import 'package:mime/mime.dart';

// ignore: constant_identifier_names
enum FileType { IMAGE, VIDEO, AUDIO, TEXT, UNKNOWN }

extension FileTypeExtension on File {
  FileType get fileType {
    final mimeType = lookupMimeType(path);
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

  bool get isImageFile => fileType == FileType.IMAGE;
  bool get isVideoFile => fileType == FileType.VIDEO;
  bool get isAudioFile => fileType == FileType.AUDIO;
  bool get isTextFile => fileType == FileType.TEXT;
}
