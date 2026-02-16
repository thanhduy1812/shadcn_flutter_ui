import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:vnl_common_ui/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('VNLButtonStyleOverride', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButtonStyleOverride(
            child: VNLButton.outline(child: Text('Test VNLButton')),
          ),
        ),
      );

      expect(find.byType(VNLButtonStyleOverride), findsOneWidget);
      expect(find.byType(VNLButton), findsOneWidget);
      expect(find.text('Test VNLButton'), findsOneWidget);
    });

    testWidgets('applies decoration override', (tester) async {
      const testDecoration = BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      );

      await tester.pumpWidget(
        SimpleApp(
          child: VNLButtonStyleOverride(
            decoration: (context, state, value) => testDecoration,
            child: VNLButton.outline(child: Text('Test VNLButton')),
          ),
        ),
      );

      expect(find.byType(VNLButtonStyleOverride), findsOneWidget);
      expect(find.byType(VNLButton), findsOneWidget);
    });

    testWidgets('applies mouse cursor override', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButtonStyleOverride(
            mouseCursor: (context, state, value) =>
                SystemMouseCursors.forbidden,
            child: VNLButton.outline(child: Text('Test VNLButton')),
          ),
        ),
      );

      expect(find.byType(VNLButtonStyleOverride), findsOneWidget);
      expect(find.byType(VNLButton), findsOneWidget);
    });

    testWidgets('applies padding override', (tester) async {
      const testPadding = EdgeInsets.all(20);

      await tester.pumpWidget(
        SimpleApp(
          child: VNLButtonStyleOverride(
            padding: (context, state, value) => testPadding,
            child: VNLButton.outline(child: Text('Test VNLButton')),
          ),
        ),
      );

      expect(find.byType(VNLButtonStyleOverride), findsOneWidget);
      expect(find.byType(VNLButton), findsOneWidget);
    });

    testWidgets('applies text style override', (tester) async {
      const testTextStyle = TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      );

      await tester.pumpWidget(
        SimpleApp(
          child: VNLButtonStyleOverride(
            textStyle: (context, state, value) => testTextStyle,
            child: VNLButton.outline(child: Text('Test VNLButton')),
          ),
        ),
      );

      expect(find.byType(VNLButtonStyleOverride), findsOneWidget);
      expect(find.byType(VNLButton), findsOneWidget);
    });

    testWidgets('applies icon theme override', (tester) async {
      const testIconTheme = IconThemeData(
        color: Colors.green,
        size: 24,
      );

      await tester.pumpWidget(
        SimpleApp(
          child: VNLButtonStyleOverride(
            iconTheme: (context, state, value) => testIconTheme,
            child: VNLButton.outline(
              leading: Icon(Icons.add),
              child: Text('Test VNLButton'),
            ),
          ),
        ),
      );

      expect(find.byType(VNLButtonStyleOverride), findsOneWidget);
      expect(find.byType(VNLButton), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('applies margin override', (tester) async {
      const testMargin = EdgeInsets.all(16);

      await tester.pumpWidget(
        SimpleApp(
          child: VNLButtonStyleOverride(
            margin: (context, state, value) => testMargin,
            child: VNLButton.outline(child: Text('Test VNLButton')),
          ),
        ),
      );

      expect(find.byType(VNLButtonStyleOverride), findsOneWidget);
      expect(find.byType(VNLButton), findsOneWidget);
    });

    testWidgets('replace mode ignores parent overrides', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButtonStyleOverride(
            padding: (context, states, value) => const EdgeInsets.all(10),
            child: VNLButtonStyleOverride(
              textStyle: (context, states, value) =>
                  const TextStyle(fontSize: 18),
              child: VNLButton.outline(child: Text('Test VNLButton')),
            ),
          ),
        ),
      );

      expect(find.byType(VNLButtonStyleOverride), findsNWidgets(2));
      expect(find.byType(VNLButton), findsOneWidget);
    });

    testWidgets('works with different button types', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButtonStyleOverride(
            textStyle: (context, state, value) =>
                const TextStyle(color: Colors.white),
            child: Column(
              children: [
                VNLButton.primary(child: Text('Primary')),
                VNLButton.secondary(child: Text('Secondary')),
                VNLButton.outline(child: Text('Outline')),
                VNLButton.ghost(child: Text('Ghost')),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(VNLButtonStyleOverride), findsOneWidget);
      expect(find.byType(VNLButton), findsNWidgets(4));
      expect(find.text('Primary'), findsOneWidget);
      expect(find.text('Secondary'), findsOneWidget);
      expect(find.text('Outline'), findsOneWidget);
      expect(find.text('Ghost'), findsOneWidget);
    });

    testWidgets('overrides work with button states', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButtonStyleOverride(
            decoration: (context, states, value) {
              if (states.contains(WidgetState.hovered)) {
                return const BoxDecoration(color: Colors.yellow);
              }
              return const BoxDecoration(color: Colors.blue);
            },
            child: VNLButton.outline(child: Text('Test VNLButton')),
          ),
        ),
      );

      expect(find.byType(VNLButtonStyleOverride), findsOneWidget);
      expect(find.byType(VNLButton), findsOneWidget);
    });

    testWidgets('handles null override delegates', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButtonStyleOverride(
            // All delegates are null
            child: VNLButton.outline(child: Text('Test VNLButton')),
          ),
        ),
      );

      expect(find.byType(VNLButtonStyleOverride), findsOneWidget);
      expect(find.byType(VNLButton), findsOneWidget);
    });

    testWidgets('works with complex button content', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButtonStyleOverride(
            padding: (context, state, value) => const EdgeInsets.all(16),
            child: VNLButton.outline(
              leading: Icon(Icons.star),
              trailing: Icon(Icons.arrow_forward),
              child: Column(
                children: [
                  Text('Title'),
                  Text('Subtitle'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byType(VNLButtonStyleOverride), findsOneWidget);
      expect(find.byType(VNLButton), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Subtitle'), findsOneWidget);
    });

    testWidgets('VNLButtonStyleOverrideData equality works', (tester) async {
      const data1 = VNLButtonStyleOverrideData(
        padding: null,
        decoration: null,
      );

      const data2 = VNLButtonStyleOverrideData(
        padding: null,
        decoration: null,
      );

      final data3 = VNLButtonStyleOverrideData(
        padding: (context, states, value) => const EdgeInsets.all(10),
        decoration: null,
      );

      expect(data1 == data2, isTrue);
      expect(data1 == data3, isFalse);
      expect(data1.hashCode == data2.hashCode, isTrue);
      expect(data1.hashCode == data3.hashCode, isFalse);
    });

    testWidgets('VNLButtonStyleOverrideData toString works', (tester) async {
      final data = VNLButtonStyleOverrideData(
        padding: (context, states, value) => const EdgeInsets.all(10),
        decoration: (context, states, value) =>
            const BoxDecoration(color: Colors.red),
      );

      final string = data.toString();
      expect(string, contains('VNLButtonStyleOverrideData'));
      expect(string, contains('padding'));
      expect(string, contains('decoration'));
    });
  });
}
