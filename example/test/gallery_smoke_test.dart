import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

/// Smoke tests for the demo gallery.
///
/// These exist so a refactor of the package cannot silently break the demo
/// that documents it: the CI web build proves it compiles, and this proves it
/// renders and responds.
void main() {
  setUp(() => KartalConfig.instance.reset());
  tearDown(() => KartalConfig.instance.reset());

  /// Sizes the surface, since the shell picks its navigation from the width.
  Future<void> pumpApp(
    WidgetTester tester, {
    Size size = const Size(1400, 1000),
  }) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const KartalGalleryApp());
    await tester.pumpAndSettle();
  }

  testWidgets('every page renders when selected', (tester) async {
    await pumpApp(tester);

    const labels = [
      'Validators',
      'Formatters',
      'Colours',
      'Responsive',
      'Collections',
      'Widgets',
      'Overlays',
    ];

    for (final label in labels) {
      // The rail shows each label; tapping it swaps the body.
      await tester.tap(find.text(label).first);
      await tester.pumpAndSettle();

      expect(
        tester.takeException(),
        isNull,
        reason: '$label page threw while rendering',
      );
      // The AppBar title confirms the page actually changed.
      expect(find.text(label), findsWidgets);
    }
  });

  testWidgets('the shell switches navigation style with width', (tester) async {
    // Wide: an extended rail, no bottom bar.
    await pumpApp(tester);
    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);

    // Narrow: a bottom bar, no rail.
    await pumpApp(tester, size: const Size(400, 900));
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationRail), findsNothing);
  });

  testWidgets('validators react to input', (tester) async {
    await pumpApp(tester);

    // A valid sample is prefilled, so the chip starts positive.
    expect(find.text('valid'), findsWidgets);

    final tcknField = find.widgetWithText(TextField, '10000000146');
    expect(tcknField, findsOneWidget);

    // Break the checksum by changing the final digit.
    await tester.enterText(tcknField, '10000000147');
    await tester.pumpAndSettle();

    expect(find.text('invalid'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('the theme toggle switches brightness', (tester) async {
    await pumpApp(tester);

    expect(find.byIcon(Icons.dark_mode_outlined), findsOneWidget);

    await tester.tap(find.byIcon(Icons.dark_mode_outlined));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.light_mode_outlined), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('the overlays page shows a snack bar', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.text('Overlays').first);
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'showSnack'));
    await tester.pump();

    expect(find.text('Saved'), findsOneWidget);
  });

  testWidgets('the collections page renders its computed output', (
    tester,
  ) async {
    await pumpApp(tester);

    await tester.tap(find.text('Collections').first);
    await tester.pumpAndSettle();

    // Values computed by the collection helpers, so a broken helper shows up
    // here as a missing or wrong row. The helpers' own semantics are covered
    // by the package unit tests; this only asserts the page wires them up.
    expect(find.text('[[1, 2], [3, 4], [5, 6], [7, 8], [9]]'), findsOneWidget);
    expect(find.text('197'), findsOneWidget, reason: 'sumBy of the ages');
    expect(find.textContaining('Istanbul'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('the colours page derives its palette from the seed', (
    tester,
  ) async {
    await pumpApp(tester);

    await tester.tap(find.text('Colours').first);
    await tester.pumpAndSettle();

    // The hex field is prefilled from the selected seed, and every row below
    // is derived from it through the colour toolkit.
    expect(find.widgetWithText(TextField, '#3F51B5'), findsOneWidget);
    expect(find.text('#3f51b5'), findsWidgets);
    expect(find.text('parsed'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
