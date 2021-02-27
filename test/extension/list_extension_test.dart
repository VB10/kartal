import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

void main() {
  List? values;

  test('list item not null check', () {
    expect(values.isNotNullOrEmpty, true);
  });
}
