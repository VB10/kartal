mixin StringMaskMixin {
  String? get value;

  String maskEmail() {
    if (value == null || value!.isEmpty) return '';
    final parts = value!.split('@');
    if (parts.length != 2) return value!;
    final local = parts[0];
    final domain = parts[1];
    if (local.length <= 2) {
      return '${local[0]}***@$domain';
    }
    return '${local.substring(0, 2)}***@$domain';
  }

  String maskPhone() {
    if (value == null || value!.isEmpty) return '';
    final cleaned = value!.replaceAll(RegExp(r'[^\d+]'), '');
    if (cleaned.length < 4) return cleaned;
    final visible = cleaned.substring(cleaned.length - 4);
    final prefix = cleaned.startsWith('+') ? '+' : '';
    return '$prefix***$visible';
  }

  String maskCreditCard() {
    if (value == null || value!.isEmpty) return '';
    final cleaned = value!.replaceAll(RegExp(r'[^\d]'), '');
    if (cleaned.length < 4) return cleaned;
    final lastFour = cleaned.substring(cleaned.length - 4);
    return '**** **** **** $lastFour';
  }

  String mask(String pattern) {
    if (value == null || value!.isEmpty) return '';
    final cleaned = value!.replaceAll(RegExp(r'[^\d]'), '');
    var result = '';
    var index = 0;
    for (var i = 0; i < pattern.length && index < cleaned.length; i++) {
      if (pattern[i] == 'X') {
        result += cleaned[index];
        index++;
      } else {
        result += pattern[i];
      }
    }
    return result;
  }

  String maskSensitive({int visibleStart = 2, int visibleEnd = 2}) {
    if (value == null || value!.isEmpty) return '';
    if (value!.length <= visibleStart + visibleEnd) {
      return '*' * value!.length;
    }
    final start = value!.substring(0, visibleStart);
    final end = value!.substring(value!.length - visibleEnd);
    final middle = '*' * (value!.length - visibleStart - visibleEnd);
    return '$start$middle$end';
  }
}
