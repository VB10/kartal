import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/src/file/file_type.dart';
import 'package:kartal/src/index.dart';
// ignore: avoid_relative_lib_imports

void main() {
  test('Filetype Extension Returning File Type', () {
    final testFile = File('/test/file/path/testFile.jpeg');

    expect(testFile.ext.fileType, FileType.IMAGE);
  });

  test('FileType Extension .isImageFile Checking', () {
    final testFile = File('/test/file/path/testFile.jpeg');

    expect(testFile.ext.isImageFile, true);
  });

  test('FileType Extension .isVideoFile Checking', () {
    final testFile = File('/test/file/path/testFile.mp4');

    expect(testFile.ext.isVideoFile, true);
  });

  test('FileType Extension .isAudioFile Checking', () {
    final testFile = File('/test/file/path/testFile.mp3');

    expect(testFile.ext.isAudioFile, true);
  });

  test('FileType Extension .isTextFile Checking', () {
    final testFile = File('/test/file/path/testFile.txt');

    expect(testFile.ext.isTextFile, true);
  });

  test('FileType Extension Unknown Type', () {
    final testFile = File('/test/file/path/testFile.asdasrsr');

    expect(testFile.ext.fileType, FileType.UNKNOWN);
  });
}
