import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';
import 'package:kartal/src/utility/http_result.dart';

void main() {
  test('Test randomColorValue property', () {
    const colorRange = 256;
    final randomColor = colorRange.ext.randomColorValue;
    expect(
      randomColor,
      isNonNegative,
    ); // Rastgele değer 0 veya daha büyük olmalı
    expect(
      randomColor,
      lessThan(colorRange),
    ); // Rastgele değer, renk aralığından küçük olmalı
  });

  test('IntegerExt.httpStatus property', () {
    final httpStatus = 200.ext.httpStatus;
    expect(
      httpStatus,
      HttpResult.success,
    ); // 200, başarılı bir durumu temsil etmeli
  });
}
