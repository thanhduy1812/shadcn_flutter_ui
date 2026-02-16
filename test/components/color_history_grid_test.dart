import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:vnl_common_ui/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('VNLColorHistoryGrid', () {
    testWidgets('renders with empty history', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLRecentColorsScope(
            child: Builder(builder: (context) {
              return VNLColorHistoryGrid(
                storage: VNLColorHistoryStorage.of(context),
              );
            }),
          ),
        ),
      );

      expect(find.byType(VNLColorHistoryGrid), findsOneWidget);
    });

    testWidgets('renders recent colors', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLRecentColorsScope(
            initialRecentColors: [Colors.red, Colors.blue],
            child: Builder(builder: (context) {
              return VNLColorHistoryGrid(
                storage: VNLColorHistoryStorage.of(context),
              );
            }),
          ),
        ),
      );

      // We expect to find buttons representing the colors
      // The grid tiles are Buttons containing Containers with the color
      expect(find.byType(VNLButton), findsWidgets);
    });

    testWidgets('triggers onColorPicked', (tester) async {
      Color? pickedColor;
      await tester.pumpWidget(
        SimpleApp(
          child: VNLRecentColorsScope(
            initialRecentColors: [Colors.red],
            child: Builder(builder: (context) {
              return VNLColorHistoryGrid(
                storage: VNLColorHistoryStorage.of(context),
                onColorPicked: (color) => pickedColor = color,
              );
            }),
          ),
        ),
      );

      // Find the button for the red color
      // Since it's the first one, we can try tapping the first button found
      await tester.tap(find.byType(VNLButton).first);
      await tester.pump();

      expect(pickedColor, equals(Colors.red));
    });

    testWidgets('respects maxTotalColors', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLRecentColorsScope(
            initialRecentColors: [Colors.red, Colors.blue, Colors.green],
            child: Builder(builder: (context) {
              return VNLColorHistoryGrid(
                storage: VNLColorHistoryStorage.of(context),
                maxTotalColors: 2,
              );
            }),
          ),
        ),
      );

      // Should only show 2 color buttons (plus potentially empty slots if grid logic dictates,
      // but let's check if we can find at least 2 buttons that are NOT empty slots if implemented that way)
      // The implementation uses Expanded(SizedBox()) for empty slots.
      // The actual color tiles are Buttons.
      // So we should find exactly 2 Buttons if the grid only renders buttons for valid colors.
      // Looking at source: _buildGridTile returns a VNLButton even for null color (empty slot).
      // Wait, source says:
      // if (color == null) { return AspectRatio(..., child: VNLButton(... child: SizedBox.shrink())); }
      // So empty slots are also Buttons.

      // However, the loop condition is:
      // i < storage.capacity && (maxTotalColors == null || i < maxTotalColors!)
      // So it stops creating tiles after maxTotalColors.
      // So we should expect exactly 2 buttons if maxTotalColors is 2.

      expect(find.byType(VNLButton), findsNWidgets(2));
    });
  });
}
