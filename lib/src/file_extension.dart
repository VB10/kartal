import 'dart:io';
import 'package:mime/mime.dart';
import 'package:kartal/src/constants/file_constants.dart';

// ignore: constant_identifier_names
enum FileType { IMAGE, VIDEO, AUDIO, TEXT, UNKNOWN }

extension FileTypeExtension on File {
  FileType get fileType {
    final mimeType = lookupMimeType(path);
    if (mimeType?.startsWith(FileConstants.instance.imageType) ?? false) {
      return FileType.IMAGE;
    }
    if (mimeType?.startsWith(FileConstants.instance.videoType) ?? false) {
      return FileType.VIDEO;
    }
    if (mimeType?.startsWith(FileConstants.instance.audioType) ?? false) {
      return FileType.AUDIO;
    }
    if (mimeType?.startsWith(FileConstants.instance.textType) ?? false) {
      return FileType.TEXT;
    }
    return FileType.UNKNOWN;
  }

  bool get isImageFile => fileType == FileType.IMAGE ? true : false;
  bool get isVideoFile => fileType == FileType.VIDEO ? true : false;
  bool get isAudioFile => fileType == FileType.AUDIO ? true : false;
  bool get isTextFile => fileType == FileType.TEXT ? true : false;
}
