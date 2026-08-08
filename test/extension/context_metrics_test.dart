import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kartal/kartal.dart';

// A 400x800 viewport keeps the derived values easy to verify by hand:
// low = 8, normal = 16, medium = 32, high = 80 (fractions of the height),
// and the border radii are fractions of the width.
const _width = 400.0;
const _height = 800.0;

const double _low = _height * 0.01; // 8
const double _normal = _height * 0.02; // 16
const double _medium = _height * 0.04; // 32
const double _high = _height * 0.1; // 80

Future<BuildContext> _pump(WidgetTester tester) async {
  late BuildContext captured;

  await tester.pumpWidget(
    const MediaQuery(
      data: MediaQueryData(size: Size(_width, _height)),
      child: MaterialApp(home: SizedBox.shrink()),
    ),
  );
  await tester.pumpWidget(
    MediaQuery(
      data: const MediaQueryData(size: Size(_width, _height)),
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
  group('context.sized', () {
    testWidgets('exposes the viewport and derived values', (tester) async {
      final sized = (await _pump(tester)).sized;

      expect(sized.width, _width);
      expect(sized.height, _height);
      expect(sized.lowValue, _low);
      expect(sized.normalValue, _normal);
      expect(sized.mediumValue, _medium);
      expect(sized.highValue, _high);
    });

    testWidgets('dynamicWidth and dynamicHeight scale the viewport', (
      tester,
    ) async {
      final sized = (await _pump(tester)).sized;

      expect(sized.dynamicWidth(0.5), _width * 0.5);
      expect(sized.dynamicHeight(0.25), _height * 0.25);
      expect(sized.dynamicWidth(0), 0);
      expect(sized.dynamicHeight(1), _height);
    });

    testWidgets('the empty sized boxes carry their fractions', (tester) async {
      final sized = (await _pump(tester)).sized;

      expect(sized.emptySizedWidthBoxLow.width, 0.01);
      expect(sized.emptySizedWidthBoxLow3x.width, 0.03);
      expect(sized.emptySizedWidthBoxNormal.width, 0.05);
      expect(sized.emptySizedWidthBoxHigh.width, 0.1);

      expect(sized.emptySizedHeightBoxLow.height, 0.01);
      expect(sized.emptySizedHeightBoxLow3x.height, 0.03);
      expect(sized.emptySizedHeightBoxNormal.height, 0.05);
      expect(sized.emptySizedHeightBoxHigh.height, 0.1);
    });

    testWidgets('the empty sized boxes render at the scaled size', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(size: Size(_width, _height)),
          child: MaterialApp(
            home: Column(
              children: [
                SpaceSizedHeightBox(height: 0.1),
                SpaceSizedWidthBox(width: 0.25),
              ],
            ),
          ),
        ),
      );

      expect(
        tester.getSize(find.byType(SpaceSizedHeightBox)).height,
        _height * 0.1,
      );
      expect(
        tester.getSize(find.byType(SpaceSizedWidthBox)).width,
        _width * 0.25,
      );
    });

    test('the empty sized boxes reject out of range fractions', () {
      expect(() => SpaceSizedHeightBox(height: 0), throwsAssertionError);
      expect(() => SpaceSizedHeightBox(height: 1.5), throwsAssertionError);
      expect(() => SpaceSizedWidthBox(width: -1), throwsAssertionError);
      expect(() => SpaceSizedWidthBox(width: 2), throwsAssertionError);
    });
  });

  group('context.padding', () {
    testWidgets('all-sides padding', (tester) async {
      final padding = (await _pump(tester)).padding;

      expect(padding.low, const EdgeInsets.all(_low));
      expect(padding.normal, const EdgeInsets.all(_normal));
      expect(padding.medium, const EdgeInsets.all(_medium));
      expect(padding.high, const EdgeInsets.all(_high));
    });

    testWidgets('horizontal padding', (tester) async {
      final padding = (await _pump(tester)).padding;

      expect(
        padding.horizontalLow,
        const EdgeInsets.symmetric(horizontal: _low),
      );
      expect(
        padding.horizontalNormal,
        const EdgeInsets.symmetric(horizontal: _normal),
      );
      expect(
        padding.horizontalMedium,
        const EdgeInsets.symmetric(horizontal: _medium),
      );
      expect(
        padding.horizontalHigh,
        const EdgeInsets.symmetric(horizontal: _high),
      );
    });

    testWidgets('vertical padding', (tester) async {
      final padding = (await _pump(tester)).padding;

      expect(padding.verticalLow, const EdgeInsets.symmetric(vertical: _low));
      expect(
        padding.verticalNormal,
        const EdgeInsets.symmetric(vertical: _normal),
      );
      expect(
        padding.verticalMedium,
        const EdgeInsets.symmetric(vertical: _medium),
      );
      expect(padding.verticalHigh, const EdgeInsets.symmetric(vertical: _high));
    });

    testWidgets('single side padding', (tester) async {
      final padding = (await _pump(tester)).padding;

      expect(padding.onlyLeftLow, const EdgeInsets.only(left: _low));
      expect(padding.onlyLeftNormal, const EdgeInsets.only(left: _normal));
      expect(padding.onlyLeftMedium, const EdgeInsets.only(left: _medium));
      expect(padding.onlyLeftHigh, const EdgeInsets.only(left: _high));

      expect(padding.onlyRightLow, const EdgeInsets.only(right: _low));
      expect(padding.onlyRightNormal, const EdgeInsets.only(right: _normal));
      expect(padding.onlyRightMedium, const EdgeInsets.only(right: _medium));
      expect(padding.onlyRightHigh, const EdgeInsets.only(right: _high));

      expect(padding.onlyTopLow, const EdgeInsets.only(top: _low));
      expect(padding.onlyTopNormal, const EdgeInsets.only(top: _normal));
      expect(padding.onlyTopMedium, const EdgeInsets.only(top: _medium));
      expect(padding.onlyTopHigh, const EdgeInsets.only(top: _high));

      expect(padding.onlyBottomLow, const EdgeInsets.only(bottom: _low));
      expect(padding.onlyBottomNormal, const EdgeInsets.only(bottom: _normal));
      expect(padding.onlyBottomMedium, const EdgeInsets.only(bottom: _medium));
      expect(padding.onlyBottomHigh, const EdgeInsets.only(bottom: _high));
    });
  });

  group('context.border', () {
    testWidgets('radii are fractions of the width', (tester) async {
      final border = (await _pump(tester)).border;

      expect(border.lowRadius, const Radius.circular(_width * 0.02));
      expect(border.normalRadius, const Radius.circular(_width * 0.05));
      expect(border.highRadius, const Radius.circular(_width * 0.1));
    });

    testWidgets('border radii wrap the matching radius', (tester) async {
      final border = (await _pump(tester)).border;

      expect(
        border.lowBorderRadius,
        BorderRadius.circular(_width * 0.02),
      );
      expect(
        border.normalBorderRadius,
        BorderRadius.circular(_width * 0.05),
      );
      expect(
        border.highBorderRadius,
        BorderRadius.circular(_width * 0.1),
      );
    });

    testWidgets('rounded rectangle borders use the height scale', (
      tester,
    ) async {
      final border = (await _pump(tester)).border;

      expect(
        border.roundedRectangleBorderLow,
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(_low),
          ),
        ),
      );
      expect(
        border.roundedRectangleBorderNormal,
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(_normal),
          ),
        ),
      );
      expect(
        border.roundedRectangleBorderMedium,
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(_medium),
          ),
        ),
      );
      expect(
        border.roundedRectangleBorderHigh,
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(_high),
          ),
        ),
      );
      expect(
        border.roundedRectangleAllBorderNormal,
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(_normal)),
      );
    });
  });

  group('context.general remaining members', () {
    testWidgets('theme and text theme lookups', (tester) async {
      final general = (await _pump(tester)).general;

      expect(general.appTheme, isA<ThemeData>());
      expect(general.textTheme, isA<TextTheme>());
      expect(general.primaryTextTheme, isA<TextTheme>());
      expect(general.colorScheme, isA<ColorScheme>());
      expect(general.mediaQuery, isA<MediaQueryData>());
      expect(general.mediaSize, const Size(_width, _height));
    });

    testWidgets('keyboard state reflects the view insets', (tester) async {
      late BuildContext captured;
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(
            size: Size(_width, _height),
            viewInsets: EdgeInsets.only(bottom: 280),
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

      expect(captured.general.isKeyBoardOpen, isTrue);
      expect(captured.general.keyboardPadding, 280);
      expect(captured.general.mediaViewInset.bottom, 280);
    });

    testWidgets('mediaTextScale scales a font size', (tester) async {
      final general = (await _pump(tester)).general;

      expect(general.mediaTextScale(16), greaterThan(0));
    });

    testWidgets('focusNode and unfocus reach the focus scope', (tester) async {
      final context = await _pump(tester);

      expect(context.general.focusNode, isA<FocusNode>());
      // Should be a no-op rather than throwing when nothing has focus.
      expect(context.general.unfocus, returnsNormally);
    });
  });
}
