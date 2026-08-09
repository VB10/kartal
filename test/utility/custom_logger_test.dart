import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';
import 'package:kartal/src/exception/generic_type_exception.dart';
import 'package:kartal/src/exception/package_info_exception.dart';

void main() {
  group('CustomLogger.showError', () {
    test('logs without throwing', () {
      // Tests run in debug mode, so this takes the logging branch.
      expect(
        () => CustomLogger.showError<String>('something went wrong'),
        returnsNormally,
      );
    });

    test('accepts any object, not just strings', () {
      expect(
        () => CustomLogger.showError<int>(Exception('boom')),
        returnsNormally,
      );
      expect(
        () => CustomLogger.showError<List<int>>(StateError('bad')),
        returnsNormally,
      );
    });

    test('suppressing the debug-mode guard still does not throw', () {
      expect(
        () => CustomLogger.showError<String>('x', isShowDebugMode: false),
        returnsNormally,
      );
    });
  });

  group('exceptions', () {
    test('ListTypeNotSupported describes itself', () {
      expect(
        const ListTypeNotSupported().toString(),
        'List type is not supported',
      );
    });

    test('ListTypeNotSupported is an Exception', () {
      expect(const ListTypeNotSupported(), isA<Exception>());
    });

    test('PackageInfoNotFound points at the fix', () {
      final exception = PackageInfoNotFound();

      expect(exception, isA<Exception>());
      expect(exception.description, contains('initPackageInfo'));
      expect(exception.toString(), exception.description);
    });

    test('toPrimitiveFromGeneric throws ListTypeNotSupported for lists', () {
      // The one place the exception is actually raised.
      expect(
        () => '1,2,3'.ext.toPrimitiveFromGeneric<List<int>>(),
        throwsA(isA<ListTypeNotSupported>()),
      );
    });
  });
}
