import 'package:flutter/material.dart';
import 'package:kartal/src/private/mixin/string/string_core_mixin.dart';
import 'package:kartal/src/private/mixin/string/string_platform_mixin.dart';
import 'package:kartal/src/private/mixin/string/string_share_mixin.dart';
import 'package:kartal/src/private/mixin/string/string_validator_mixin.dart';

/// Extension methods for [String] to provide additional functionalities.
extension StringExtension on String? {
  /// Provides convenient access to additional functionalities for [String].
  _StringExtension get ext => _StringExtension(this);
}

/// Extension methods for [String] to provide additional functionalities.
extension StringDefaultExtension on String {
  /// Provides convenient access to additional functionalities for [String].
  _StringExtension get ext => _StringExtension(this);
}

final class _StringExtension
    with
        StringPlatformMixin,
        StringShareMixin,
        StringValidatorMixin,
        StringCoreMixin {
  _StringExtension(String? value) : _value = value;

  final String? _value;

  @override
  String get value => _value ?? '';

  /// Returns the length of the string.
  int get lineLength => '\n'.allMatches(_value ?? '').length + 1;

  /// Returns the length of the string.
  Color get color => Color(int.parse('0xff$_value'));

  /// [_value] convert to color code
  int? get colorCode => int.tryParse('0xFF$_value');

  /// Returns the color of the string.
  Color get toColor => Color(colorCode ?? 0xFFFFFFFF);

  /// Random image -> picsum 200x300
  String get randomImage => 'https://picsum.photos/200/300';

  /// Random image -> picsum 200x200
  String get randomSquareImage => 'https://picsum.photos/200';

  /// Random image -> picsum 200x300
  String get customProfileImage => 'https://www.gravatar.com/avatar/?d=mp';

  /// Profile image from gravatar
  String get customHighProfileImage =>
      'https://www.gravatar.com/avatar/?d=mp&s=200';

  /// Returns the value of map with bearer token
  Map<String, dynamic> get bearer => {'Authorization': 'Bearer $_value'};
}
