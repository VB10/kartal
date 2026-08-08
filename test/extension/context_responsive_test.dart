import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

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
  // KartalConfig is a process-wide singleton, so reset it around every test to
  // stop configuration leaking between them.
  setUp(() => KartalConfig.instance.reset());
  tearDown(() => KartalConfig.instance.reset());

  group('breakpoint', () {
    const cases = <({double width, DeviceBreakpoint expected})>[
      (width: 200, expected: DeviceBreakpoint.small),
      (width: 450, expected: DeviceBreakpoint.medium),
      (width: 750, expected: DeviceBreakpoint.expanded),
      (width: 1200, expected: DeviceBreakpoint.large),
    ];

    for (final testCase in cases) {
      testWidgets('${testCase.width.toInt()}px is ${testCase.expected.name}', (
        tester,
      ) async {
        final context = await _contextAtWidth(tester, testCase.width);

        expect(context.device.breakpoint, testCase.expected);
      });
    }

    testWidgets('isSmall and isLarge convenience getters', (tester) async {
      final small = await _contextAtWidth(tester, 200);
      expect(small.device.breakpoint.isSmall, isTrue);
      expect(small.device.breakpoint.isLarge, isFalse);

      final large = await _contextAtWidth(tester, 1200);
      expect(large.device.breakpoint.isLarge, isTrue);
    });
  });

  group('responsive', () {
    testWidgets('picks the value for the current band', (tester) async {
      final small = await _contextAtWidth(tester, 200);
      expect(
        small.device.responsive(small: 1, medium: 2, expanded: 3, large: 4),
        1,
      );

      final medium = await _contextAtWidth(tester, 450);
      expect(
        medium.device.responsive(small: 1, medium: 2, expanded: 3, large: 4),
        2,
      );

      final expanded = await _contextAtWidth(tester, 750);
      expect(
        expanded.device.responsive(small: 1, medium: 2, expanded: 3, large: 4),
        3,
      );

      final large = await _contextAtWidth(tester, 1200);
      expect(
        large.device.responsive(small: 1, medium: 2, expanded: 3, large: 4),
        4,
      );
    });

    testWidgets('falls back to the next narrower value supplied', (
      tester,
    ) async {
      // Only small and large given: the middle bands must not be left
      // undefined, they fall back to small.
      final medium = await _contextAtWidth(tester, 450);
      expect(medium.device.responsive(small: 1, large: 4), 1);

      final expanded = await _contextAtWidth(tester, 750);
      expect(expanded.device.responsive(small: 1, large: 4), 1);

      final large = await _contextAtWidth(tester, 1200);
      expect(large.device.responsive(small: 1, large: 4), 4);
    });

    testWidgets('works with only the required small value', (tester) async {
      final large = await _contextAtWidth(tester, 1200);

      expect(large.device.responsive(small: 'only'), 'only');
    });

    testWidgets('carries non-numeric types such as widgets', (tester) async {
      final small = await _contextAtWidth(tester, 200);

      final widget = small.device.responsive<Widget>(
        small: const Text('narrow'),
        large: const Text('wide'),
      );

      expect((widget as Text).data, 'narrow');
    });
  });

  group('configurable breakpoints', () {
    testWidgets('KartalConfig overrides the thresholds', (tester) async {
      KartalConfig.instance.configure(
        breakpoints: const KartalBreakpoints(
          small: 480,
          medium: 768,
          large: 1200,
        ),
      );

      // 450 is medium under the defaults but small under this config.
      final context = await _contextAtWidth(tester, 450);
      expect(context.device.breakpoint, DeviceBreakpoint.small);
      expect(context.device.isSmallScreen, isTrue);

      final medium = await _contextAtWidth(tester, 500);
      expect(medium.device.breakpoint, DeviceBreakpoint.medium);

      // 1000 is large under the defaults but expanded under this config.
      final expanded = await _contextAtWidth(tester, 1000);
      expect(expanded.device.breakpoint, DeviceBreakpoint.expanded);
    });

    testWidgets('reset restores the defaults', (tester) async {
      KartalConfig.instance.configure(
        breakpoints: const KartalBreakpoints(
          small: 480,
          medium: 768,
          large: 1200,
        ),
      );
      KartalConfig.instance.reset();

      final context = await _contextAtWidth(tester, 450);
      expect(context.device.breakpoint, DeviceBreakpoint.medium);
    });

    test('breakpoints must be strictly increasing', () {
      expect(
        () => KartalBreakpoints(small: 600, medium: 300),
        throwsA(isA<AssertionError>()),
      );
    });
  });

  group('KartalConfig date labels', () {
    test('differenceTime uses the configured label by default', () {
      KartalConfig.instance.configure(
        dateLabel: const DateLocalizationLabel.tr(),
      );

      final twoDaysAgo = DateTime.now().subtract(const Duration(days: 2));

      expect(twoDaysAgo.ext.differenceTime(), '2 gün önce');
    });

    test('an explicit label still wins over the configured one', () {
      KartalConfig.instance.configure(
        dateLabel: const DateLocalizationLabel.tr(),
      );

      final twoDaysAgo = DateTime.now().subtract(const Duration(days: 2));

      expect(
        twoDaysAgo.ext.differenceTime(
          localizationLabel: const DateLocalizationLabel(),
        ),
        '2 days ago',
      );
    });

    test('the default remains English when unconfigured', () {
      final twoDaysAgo = DateTime.now().subtract(const Duration(days: 2));

      expect(twoDaysAgo.ext.differenceTime(), '2 days ago');
    });
  });

  group('general extension additions', () {
    // Two separate tests rather than switching themes inside one: MaterialApp
    // wraps its child in an AnimatedTheme, so a single pump after a theme swap
    // still reports a value lerped toward the previous theme.
    testWidgets('isDarkMode is true under a dark theme', (tester) async {
      late BuildContext captured;
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          home: Builder(
            builder: (context) {
              captured = context;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(captured.general.isDarkMode, isTrue);
      expect(captured.general.isLightMode, isFalse);
    });

    testWidgets('isLightMode is true under a light theme', (tester) async {
      late BuildContext captured;
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Builder(
            builder: (context) {
              captured = context;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(captured.general.isLightMode, isTrue);
      expect(captured.general.isDarkMode, isFalse);
    });

    testWidgets('orientation reflects the media size', (tester) async {
      final landscape = await _contextAtWidth(tester, 1200);
      expect(landscape.general.isLandscape, isTrue);
      expect(landscape.general.isPortrait, isFalse);
      expect(landscape.general.orientation, Orientation.landscape);

      final portrait = await _contextAtWidth(tester, 400);
      expect(portrait.general.isPortrait, isTrue);
    });

    testWidgets('safe area insets are exposed', (tester) async {
      late BuildContext captured;
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(
            size: Size(400, 800),
            viewPadding: EdgeInsets.only(top: 44, bottom: 34),
          ),
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

      expect(captured.general.topPadding, 44);
      expect(captured.general.bottomPadding, 34);
      expect(captured.general.safePadding.top, 44);
    });

    testWidgets('devicePixelRatio is exposed', (tester) async {
      final context = await _contextAtWidth(tester, 400);

      expect(context.general.devicePixelRatio, greaterThan(0));
    });
  });
}
