import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

/// Pumps a widget at [width] logical pixels and hands back its context.
Future<BuildContext> _contextAtWidth(WidgetTester tester, double width) async {
  late BuildContext captured;

  await tester.pumpWidget(
    MediaQuery(
      data: MediaQueryData(size: Size(width, 800)),
      child: MaterialApp(
        home: Builder(
          builder: (context) {
            captured = context;
            return const SizedBox.shrink();
          },
        ),
      ),
    ),
  );

  return captured;
}

void main() {
  // Regression guard: isSmallScreen used to be `300 <= w < 600` and
  // isMediumScreen `600 <= w < 900`, contradicting their own documentation.
  // A 200px screen answered false to all three accessors, and the 600..900
  // band had no accessor at all.
  group('context.device breakpoints', () {
    const bands = <({double width, String expected})>[
      (width: 0, expected: 'isSmallScreen'),
      (width: 200, expected: 'isSmallScreen'),
      (width: 299, expected: 'isSmallScreen'),
      (width: 300, expected: 'isMediumScreen'),
      (width: 450, expected: 'isMediumScreen'),
      (width: 599, expected: 'isMediumScreen'),
      (width: 600, expected: 'isExpandedScreen'),
      (width: 750, expected: 'isExpandedScreen'),
      (width: 899, expected: 'isExpandedScreen'),
      (width: 900, expected: 'isLargeScreen'),
      (width: 1440, expected: 'isLargeScreen'),
    ];

    for (final band in bands) {
      final width = band.width;
      final expected = band.expected;

      testWidgets('${width.toInt()}px is $expected', (tester) async {
        final context = await _contextAtWidth(tester, width);
        final device = context.device;

        final actual = <String, bool>{
          'isSmallScreen': device.isSmallScreen,
          'isMediumScreen': device.isMediumScreen,
          'isExpandedScreen': device.isExpandedScreen,
          'isLargeScreen': device.isLargeScreen,
        };

        // Exactly one band must match, so there are no gaps or overlaps.
        expect(
          actual.entries.where((e) => e.value).map((e) => e.key),
          [expected],
          reason: 'width ${width.toInt()} resolved to $actual',
        );
      });
    }
  });
}
