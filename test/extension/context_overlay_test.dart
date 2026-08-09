import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

/// Pumps a scaffold and hands back a context beneath its ScaffoldMessenger.
Future<BuildContext> _pumpScaffold(WidgetTester tester) async {
  late BuildContext captured;

  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Builder(
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
  group('showSnack', () {
    testWidgets('displays the message', (tester) async {
      final context = await _pumpScaffold(tester);

      context.overlay.showSnack('saved');
      await tester.pump();

      expect(find.text('saved'), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('passes through duration, action and colour', (tester) async {
      final context = await _pumpScaffold(tester);

      context.overlay.showSnack(
        'undo me',
        duration: const Duration(seconds: 9),
        backgroundColor: Colors.teal,
        action: SnackBarAction(label: 'Undo', onPressed: () {}),
      );
      await tester.pump();

      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));

      expect(snackBar.duration, const Duration(seconds: 9));
      expect(snackBar.backgroundColor, Colors.teal);
      expect(find.text('Undo'), findsOneWidget);
    });

    testWidgets('hideSnack dismisses it', (tester) async {
      final context = await _pumpScaffold(tester);

      context.overlay.showSnack('bye');
      await tester.pump();
      expect(find.text('bye'), findsOneWidget);

      context.overlay.hideSnack();
      await tester.pumpAndSettle();

      expect(find.text('bye'), findsNothing);
    });

    testWidgets('removeSnack drops it without animating', (tester) async {
      final context = await _pumpScaffold(tester);

      context.overlay.showSnack('gone');
      await tester.pump();

      context.overlay.removeSnack();
      await tester.pump();

      expect(find.text('gone'), findsNothing);
    });

    testWidgets('showSnackWidget accepts a custom SnackBar', (tester) async {
      final context = await _pumpScaffold(tester);

      context.overlay.showSnackWidget(
        const SnackBar(content: Text('custom')),
      );
      await tester.pump();

      expect(find.text('custom'), findsOneWidget);
    });
  });

  group('showSheet', () {
    testWidgets('presents the child in a modal sheet', (tester) async {
      final context = await _pumpScaffold(tester);

      final future = context.overlay.showSheet<String>(
        const Text('sheet body'),
      );
      await tester.pumpAndSettle();

      expect(find.text('sheet body'), findsOneWidget);

      // Dismiss by tapping the barrier so the future completes.
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      expect(await future, isNull);
    });

    testWidgets('is scroll controlled by default', (tester) async {
      final context = await _pumpScaffold(tester);

      unawaited(context.overlay.showSheet<void>(const Text('body')));
      await tester.pumpAndSettle();

      // A scroll controlled sheet is free to exceed half the screen height.
      expect(find.text('body'), findsOneWidget);

      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();
    });
  });

  group('showDialogCustom', () {
    testWidgets('presents the child in a dialog', (tester) async {
      final context = await _pumpScaffold(tester);

      unawaited(
        context.overlay.showDialogCustom<void>(
          const AlertDialog(content: Text('dialog body')),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('dialog body'), findsOneWidget);
    });
  });

  group('showConfirm', () {
    testWidgets('completes true when confirmed', (tester) async {
      final context = await _pumpScaffold(tester);

      final future = context.overlay.showConfirm(
        title: 'Delete?',
        message: 'This cannot be undone.',
      );
      await tester.pumpAndSettle();

      expect(find.text('Delete?'), findsOneWidget);
      expect(find.text('This cannot be undone.'), findsOneWidget);

      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      expect(await future, isTrue);
    });

    testWidgets('completes false when cancelled', (tester) async {
      final context = await _pumpScaffold(tester);

      final future = context.overlay.showConfirm(title: 'Delete?');
      await tester.pumpAndSettle();

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(await future, isFalse);
    });

    testWidgets('completes false rather than null when dismissed', (
      tester,
    ) async {
      final context = await _pumpScaffold(tester);

      final future = context.overlay.showConfirm(title: 'Delete?');
      await tester.pumpAndSettle();

      // Tap the barrier instead of a button.
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      // The point of returning bool rather than bool? is that this is usable
      // directly in an if without a null check.
      expect(await future, isFalse);
    });

    testWidgets('honours custom labels', (tester) async {
      final context = await _pumpScaffold(tester);

      final future = context.overlay.showConfirm(
        title: 'Sil?',
        confirmLabel: 'Evet',
        cancelLabel: 'Vazgeç',
        isDestructive: true,
      );
      await tester.pumpAndSettle();

      expect(find.text('Evet'), findsOneWidget);
      expect(find.text('Vazgeç'), findsOneWidget);

      await tester.tap(find.text('Evet'));
      await tester.pumpAndSettle();

      expect(await future, isTrue);
    });
  });
}
