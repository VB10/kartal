import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

void main() {
  setUp(() {});

  group('Context Extension Tests', () {
    // Define the screen width and height you want to mock
    const mockWidth = 500.0;
    const mockHeight = 500.0;
    testWidgets(
        'SizedBoxExtension on context should return height and width values correctly',
        (WidgetTester tester) async {
      // Create a widget for testing that provides a MediaQuery with the desired dimensions
      await tester.pumpWidget(
        Builder(
          builder: (context) => const MaterialApp(
            home: MediaQuery(
              data: MediaQueryData(
                size: Size(
                  mockWidth,
                  mockHeight,
                ), // Set the MediaQuery size here
              ),
              child: SizedBox(),
            ),
          ),
        ),
      );

      final sizedBoxFinder = find.byType(SizedBox);
      final BuildContext context = tester.element(sizedBoxFinder);

      expect(context.sized.height, 500);
      expect(context.sized.width, 500);
      expect(context.sized.lowValue, 5);
      expect(context.sized.normalValue, 10);
      expect(context.sized.highValue, 50);
      expect(context.sized.mediumValue, 20);

      expect(context.sized.dynamicHeight(0.4), 200);
      expect(context.sized.dynamicWidth(0.4), 200);
    });

    testWidgets(
        'PaddingExtension on context should return padding values correctly',
        (WidgetTester tester) async {
      // Create a widget for testing that provides a MediaQuery with the desired dimensions
      await tester.pumpWidget(
        Builder(
          builder: (context) => const MaterialApp(
            home: MediaQuery(
              data: MediaQueryData(
                size: Size(
                  mockWidth,
                  mockHeight,
                ), // Set the MediaQuery size here
              ),
              child: SizedBox(),
            ),
          ),
        ),
      );

      final sizedBoxFinder = find.byType(SizedBox);
      final BuildContext context = tester.element(sizedBoxFinder);

      expect(context.padding.high, const EdgeInsets.all(50));
      expect(context.padding.medium, const EdgeInsets.all(20));
      expect(context.padding.low, const EdgeInsets.all(5));
      expect(context.padding.normal, const EdgeInsets.all(10));
    });

    testWidgets(
        'MediaQueryExtension on context should return mediaQuery values correctly',
        (WidgetTester tester) async {
      // Create a widget for testing that provides a MediaQuery with the desired dimensions
      await tester.pumpWidget(
        Builder(
          builder: (context) => const MaterialApp(
            themeMode: ThemeMode.light,
            home: MediaQuery(
              data: MediaQueryData(
                size: Size(
                  mockWidth,
                  mockHeight,
                ), // Set the MediaQuery size here
              ),
              child: SizedBox(),
            ),
          ),
        ),
      );

      final sizedBoxFinder = find.byType(SizedBox);
      final BuildContext context = tester.element(sizedBoxFinder);

      expect(context.general.appTheme, isA<ThemeData>());
      expect(context.general.colorScheme, isA<ColorScheme>());
      expect(context.general.mediaBrightness, Brightness.light);
      expect(context.general.mediaQuery, isA<MediaQueryData>());
      expect(context.general.mediaSize, const Size(500, 500));

      expect(context.general.randomColor, isA<MaterialColor>());
      expect(context.general.isKeyBoardOpen, false);
      expect(context.general.keyboardPadding, 0);
    });

    testWidgets(
        'BorderExtension on context should return mediaQuery values correctly',
        (WidgetTester tester) async {
      // Create a widget for testing that provides a MediaQuery with the desired dimensions
      await tester.pumpWidget(
        Builder(
          builder: (context) => const MaterialApp(
            themeMode: ThemeMode.light,
            home: MediaQuery(
              data: MediaQueryData(
                size: Size(
                  mockWidth,
                  mockHeight,
                ), // Set the MediaQuery size here
              ),
              child: SizedBox(),
            ),
          ),
        ),
      );

      final sizedBoxFinder = find.byType(SizedBox);
      final BuildContext context = tester.element(sizedBoxFinder);

      expect(context.border.lowRadius.x, 10);
      expect(context.border.normalRadius.x, 25);
      expect(context.border.highRadius.x, 50);
      expect(context.border.normalBorderRadius.topLeft.x, 25);
      expect(context.border.lowBorderRadius.topLeft.x, 10);
      expect(context.border.highBorderRadius.topLeft.x, 50);
    });

    testWidgets(
        'ContextDeviceTypeExtension on context should return mediaQuery values correctly',
        (WidgetTester tester) async {
      // Create a widget for testing that provides a MediaQuery with the desired dimensions
      await tester.pumpWidget(
        Builder(
          builder: (context) => const MaterialApp(
            themeMode: ThemeMode.light,
            home: MediaQuery(
              data: MediaQueryData(
                size: Size(
                  mockWidth,
                  mockHeight,
                ), // Set the MediaQuery size here
              ),
              child: SizedBox(),
            ),
          ),
        ),
      );

      final sizedBoxFinder = find.byType(SizedBox);
      final BuildContext context = tester.element(sizedBoxFinder);

      expect(context.device.isSmallScreen, true);
      expect(context.device.isMediumScreen, false);
      expect(context.device.isLargeScreen, false);
    });
  });

  testWidgets('unfocus removes focus from the FocusNode',
      (WidgetTester tester) async {
    // Create a widget for testing that provides the FocusNode and a TextField
    final focusNode = FocusNode();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TextField(
            focusNode: focusNode,
          ),
        ),
      ),
    );

    focusNode.requestFocus();
    await tester.pump();

    expect(focusNode.hasFocus, isTrue);

    FocusScope.of(tester.element(find.byType(TextField))).unfocus();
    await tester.pump();

    expect(focusNode.hasFocus, isFalse);
  });
}
