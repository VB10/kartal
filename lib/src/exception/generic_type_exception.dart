import 'package:flutter/material.dart';

@immutable
final class ListTypeNotSupported implements Exception {
  const ListTypeNotSupported();
  String get _description => 'List type is not supported';

  @override
  String toString() => _description;
}
