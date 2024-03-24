import 'dart:math';

part './private/integer_ext.dart';

/// Extension methods for [int] to provide additional functionalities.
extension IntegerExtension on int {
  /// Provides convenient access to additional functionalities for [int].
  IntegerExt get ext => IntegerExt(this);
}
