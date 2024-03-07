import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../example/lib/samples/context_extension_view.dart';

void main() {
  testWidgets(
    'PopupManager extension test',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: ContextExtensionView()),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Show loader'));
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 2500));
      expect(find.byType(CircularProgressIndicator), findsNothing);

      await tester.tap(find.text('Show loader with id'));
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 2500));
      expect(find.byType(CircularProgressIndicator), findsNothing);
    },
  );
}
