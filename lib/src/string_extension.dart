import 'package:flutter/material.dart';
import 'package:kartal/src/constants/regex_constants.dart';

extension StringExtension on String {
  String get tlMoney => "$this TL";
}

extension StringColorExtension on String {
  Color get color => Color(int.parse("0xff$this"));
}

extension StringValidatorExtension on String {
  bool get isNullOrEmpty => this == null || this.isEmpty;
  bool get isNotNullOrNoEmpty => !isNullOrEmpty;

  bool get isValidEmail => RegExp(RegexConstans.instance.emailRegex).hasMatch(this);
}
