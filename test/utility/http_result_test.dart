import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

void main() {
  group('HttpResult.fromStatusCode', () {
    // Every range boundary, plus the out-of-range codes on either side.
    //
    // Regression guard: this used to be written with `||` instead of `&&`
    // in the relational patterns, so the first arm matched every integer
    // and *all* status codes resolved to HttpResult.success.
    const cases = <int, HttpResult>{
      // Informational codes are not modelled, so they fall through.
      100: HttpResult.unknown,
      199: HttpResult.unknown,
      // Success.
      200: HttpResult.success,
      201: HttpResult.success,
      299: HttpResult.success,
      // Redirection.
      300: HttpResult.redirection,
      301: HttpResult.redirection,
      399: HttpResult.redirection,
      // Client error.
      400: HttpResult.clientError,
      404: HttpResult.clientError,
      422: HttpResult.clientError,
      499: HttpResult.clientError,
      // Server error.
      500: HttpResult.serverError,
      503: HttpResult.serverError,
      599: HttpResult.serverError,
      // Above the modelled range.
      600: HttpResult.unknown,
      0: HttpResult.unknown,
      -1: HttpResult.unknown,
    };

    for (final entry in cases.entries) {
      test('${entry.key} maps to ${entry.value.name}', () {
        expect(HttpResult.fromStatusCode(entry.key), entry.value);
      });
    }
  });

  group('IntegerExtension.httpStatus', () {
    test('reads through the int extension', () {
      expect(200.ext.httpStatus, HttpResult.success);
      expect(301.ext.httpStatus, HttpResult.redirection);
      expect(404.ext.httpStatus, HttpResult.clientError);
      expect(500.ext.httpStatus, HttpResult.serverError);
      expect(100.ext.httpStatus, HttpResult.unknown);
    });

    test('exposes a distinct colour per class', () {
      expect(200.ext.httpStatusColor, Colors.green);
      expect(301.ext.httpStatusColor, Colors.blue);
      expect(404.ext.httpStatusColor, Colors.orange);
      expect(500.ext.httpStatusColor, Colors.red);
      expect(100.ext.httpStatusColor, Colors.grey);
    });
  });
}
