import 'package:diacritic/diacritic.dart';
import 'package:kartal/kartal.dart';

mixin StringLocaleMixin {
  String? get value;

  String get slugify {
    if (value == null || value!.isEmpty) return '';
    final cleaned = removeAccents;
    return cleaned
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s-]'), '')
        .replaceAll(RegExp(r'[-\s]+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');
  }

  String get toTrLowerCase {
    if (value == null) return '';
    return value!
        .replaceAll('I', 'ı')
        .replaceAll('İ', 'i')
        .toLowerCase();
  }

  String get toTrUpperCase {
    if (value == null) return '';
    return value!
        .replaceAll('i', 'İ')
        .replaceAll('ı', 'I')
        .toUpperCase();
  }

  bool get isValidHexColor {
    if (value == null || value!.isEmpty) return false;
    final hexRegex = RegExp(RegexConstants.instance().hexColorRegex);
    return hexRegex.hasMatch(value!);
  }

  String get removeAccents {
    if (value == null) return '';
    return removeDiacritics(value!);
  }

  String get reversed {
    if (value == null) return '';
    return value!.split('').reversed.join();
  }

  String capitalizeFirst() {
    if (value == null || value!.isEmpty) return '';
    return value![0].toUpperCase() + value!.substring(1);
  }

  String capitalizeWords() {
    if (value == null || value!.isEmpty) return '';
    return value!
        .split(' ')
        .map((word) => word.ext.capitalizeFirst())
        .join(' ');
  }
}
