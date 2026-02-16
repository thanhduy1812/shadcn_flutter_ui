import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart' as material;
import 'package:vnl_common_ui/shadcn_flutter.dart';
import '../test_helper.dart';

void main() {
  group('VNLCard', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLCard(
            child: Text('VNLCard Content'),
          ),
        ),
      );

      expect(find.byType(VNLCard), findsOneWidget);
      expect(find.text('VNLCard Content'), findsOneWidget);
    });

    testWidgets('renders with custom padding', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLCard(
            padding: EdgeInsets.all(32.0),
            child: Text('Padded Content'),
          ),
        ),
      );

      expect(find.byType(VNLCard), findsOneWidget);
      expect(find.text('Padded Content'), findsOneWidget);
      expect(find.byType(VNLOutlinedContainer), findsOneWidget);
    });

    testWidgets('renders filled card', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLCard(
            filled: true,
            child: Text('Filled VNLCard'),
          ),
        ),
      );

      expect(find.byType(VNLCard), findsOneWidget);
      expect(find.text('Filled VNLCard'), findsOneWidget);
    });

    testWidgets('renders with custom fill color', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLCard(
            filled: true,
            fillColor: material.Colors.blue,
            child: Text('Colored VNLCard'),
          ),
        ),
      );

      expect(find.byType(VNLCard), findsOneWidget);
      expect(find.text('Colored VNLCard'), findsOneWidget);
    });

    testWidgets('renders with custom border radius', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLCard(
            borderRadius: BorderRadius.circular(16.0),
            child: Text('Rounded VNLCard'),
          ),
        ),
      );

      expect(find.byType(VNLCard), findsOneWidget);
      expect(find.text('Rounded VNLCard'), findsOneWidget);
    });

    testWidgets('renders with custom border color and width', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLCard(
            borderColor: material.Colors.red,
            borderWidth: 2.0,
            child: Text('Bordered VNLCard'),
          ),
        ),
      );

      expect(find.byType(VNLCard), findsOneWidget);
      expect(find.text('Bordered VNLCard'), findsOneWidget);
    });

    testWidgets('renders with box shadow', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLCard(
            boxShadow: [
              BoxShadow(
                color: material.Colors.black.withValues(alpha: 0.2),
                blurRadius: 8.0,
                offset: Offset(0, 4),
              )
            ],
            child: Text('Shadowed VNLCard'),
          ),
        ),
      );

      expect(find.byType(VNLCard), findsOneWidget);
      expect(find.text('Shadowed VNLCard'), findsOneWidget);
    });

    testWidgets('renders with surface effects', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLCard(
            surfaceOpacity: 0.8,
            surfaceBlur: 10.0,
            child: Text('Surface VNLCard'),
          ),
        ),
      );

      expect(find.byType(VNLCard), findsOneWidget);
      expect(find.text('Surface VNLCard'), findsOneWidget);
    });

    testWidgets('renders with custom clip behavior', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLCard(
            clipBehavior: Clip.antiAlias,
            child: Text('Clipped VNLCard'),
          ),
        ),
      );

      expect(find.byType(VNLCard), findsOneWidget);
      expect(find.text('Clipped VNLCard'), findsOneWidget);
    });

    testWidgets('renders with custom duration', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLCard(
            duration: Duration(milliseconds: 500),
            child: Text('Animated VNLCard'),
          ),
        ),
      );

      expect(find.byType(VNLCard), findsOneWidget);
      expect(find.text('Animated VNLCard'), findsOneWidget);
    });

    testWidgets('handles complex child widgets', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLCard(
            child: Column(
              children: [
                Text('Title'),
                SizedBox(height: 8),
                Text('Description'),
                Icon(Icons.star),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(VNLCard), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.byType(Column),
          findsWidgets); // May find multiple due to SimpleApp
    });

    testWidgets('applies default text style', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLCard(
            child: Text('Styled Text'),
          ),
        ),
      );

      expect(find.byType(VNLCard), findsOneWidget);
      expect(find.byType(DefaultTextStyle),
          findsWidgets); // May find multiple due to SimpleApp
      expect(find.text('Styled Text'), findsOneWidget);
    });

    testWidgets('handles empty child', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLCard(
            child: SizedBox.shrink(),
          ),
        ),
      );

      expect(find.byType(VNLCard), findsOneWidget);
      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('renders with all properties combined', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLCard(
            padding: EdgeInsets.all(24.0),
            filled: true,
            fillColor: material.Colors.green,
            borderRadius: BorderRadius.circular(12.0),
            borderColor: material.Colors.blue,
            borderWidth: 3.0,
            boxShadow: [
              BoxShadow(
                color: material.Colors.black.withValues(alpha: 0.3),
                blurRadius: 12.0,
                offset: Offset(0, 6),
              )
            ],
            surfaceOpacity: 0.9,
            surfaceBlur: 8.0,
            clipBehavior: Clip.antiAlias,
            duration: Duration(milliseconds: 300),
            child: Text('Complex VNLCard'),
          ),
        ),
      );

      expect(find.byType(VNLCard), findsOneWidget);
      expect(find.text('Complex VNLCard'), findsOneWidget);
      expect(find.byType(VNLOutlinedContainer), findsOneWidget);
    });

    testWidgets('maintains widget hierarchy', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLCard(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Nested Content'),
            ),
          ),
        ),
      );

      expect(find.byType(VNLCard), findsOneWidget);
      expect(find.byType(Padding),
          findsWidgets); // May find multiple due to SimpleApp
      expect(find.text('Nested Content'), findsOneWidget);
    });

    testWidgets('handles state changes', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLCard(
            child: Text('Initial'),
          ),
        ),
      );

      expect(find.text('Initial'), findsOneWidget);

      await tester.pumpWidget(
        SimpleApp(
          child: VNLCard(
            filled: true,
            child: Text('Updated'),
          ),
        ),
      );

      expect(find.text('Updated'), findsOneWidget);
      expect(find.text('Initial'), findsNothing);
    });
  });
}
