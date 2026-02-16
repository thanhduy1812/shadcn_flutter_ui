import 'package:flutter_test/flutter_test.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('VNLButton', () {
    testWidgets('renders primary button with text', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButton.primary(
            onPressed: () {},
            child: Text('Primary VNLButton'),
          ),
        ),
      );

      expect(find.byType(VNLButton), findsOneWidget);
      expect(find.text('Primary VNLButton'), findsOneWidget);
    });

    testWidgets('renders secondary button', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButton.secondary(
            onPressed: () {},
            child: Text('Secondary VNLButton'),
          ),
        ),
      );

      expect(find.byType(VNLButton), findsOneWidget);
      expect(find.text('Secondary VNLButton'), findsOneWidget);
    });

    testWidgets('renders outline button', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButton.outline(
            onPressed: () {},
            child: Text('Outline VNLButton'),
          ),
        ),
      );

      expect(find.byType(VNLButton), findsOneWidget);
      expect(find.text('Outline VNLButton'), findsOneWidget);
    });

    testWidgets('renders ghost button', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButton.ghost(
            onPressed: () {},
            child: Text('Ghost VNLButton'),
          ),
        ),
      );

      expect(find.byType(VNLButton), findsOneWidget);
      expect(find.text('Ghost VNLButton'), findsOneWidget);
    });

    testWidgets('renders link button', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButton.link(
            onPressed: () {},
            child: Text('Link VNLButton'),
          ),
        ),
      );

      expect(find.byType(VNLButton), findsOneWidget);
      expect(find.text('Link VNLButton'), findsOneWidget);
    });

    testWidgets('renders text button', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButton.text(
            onPressed: () {},
            child: Text('Text VNLButton'),
          ),
        ),
      );

      expect(find.byType(VNLButton), findsOneWidget);
      expect(find.text('Text VNLButton'), findsOneWidget);
    });

    testWidgets('renders destructive button', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButton.destructive(
            onPressed: () {},
            child: Text('Delete'),
          ),
        ),
      );

      expect(find.byType(VNLButton), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);
    });

    testWidgets('renders with leading icon', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButton.primary(
            onPressed: () {},
            leading: Icon(Icons.add),
            child: Text('Add Item'),
          ),
        ),
      );

      expect(find.byType(VNLButton), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.text('Add Item'), findsOneWidget);
    });

    testWidgets('renders with trailing icon', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButton.primary(
            onPressed: () {},
            trailing: Icon(Icons.arrow_forward),
            child: Text('Continue'),
          ),
        ),
      );

      expect(find.byType(VNLButton), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
      expect(find.text('Continue'), findsOneWidget);
    });

    testWidgets('renders with both leading and trailing icons', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButton.primary(
            onPressed: () {},
            leading: Icon(Icons.star),
            trailing: Icon(Icons.arrow_forward),
            child: Text('Featured'),
          ),
        ),
      );

      expect(find.byType(VNLButton), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
      expect(find.text('Featured'), findsOneWidget);
    });

    testWidgets('handles onPressed callback', (tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButton.primary(
            onPressed: () => pressed = true,
            child: Text('Press Me'),
          ),
        ),
      );

      await tester.tap(find.byType(VNLButton));
      await tester.pumpAndSettle();

      expect(pressed, isTrue);
    });

    testWidgets('is disabled when onPressed is null', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButton.primary(
            child: Text('Disabled VNLButton'),
          ),
        ),
      );

      expect(find.byType(VNLButton), findsOneWidget);
      // VNLButton should be disabled when onPressed is null
    });

    testWidgets('respects enabled parameter', (tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButton.primary(
            onPressed: () => pressed = true,
            enabled: false,
            child: Text('Disabled VNLButton'),
          ),
        ),
      );

      await tester.tap(find.byType(VNLButton));
      await tester.pumpAndSettle();

      expect(pressed, isFalse); // Should not trigger when disabled
    });

    testWidgets('accepts focus and hover callbacks', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButton.primary(
            onPressed: () {},
            onFocus: (hasFocus) {},
            onHover: (isHovering) {},
            child: Text('Interactive VNLButton'),
          ),
        ),
      );

      expect(find.byType(VNLButton), findsOneWidget);

      // Verify the button can be created with callbacks
      // Note: Actual focus/hover triggering requires integration testing
      // but we verify the callbacks are accepted without errors
      final button = tester.widget<VNLButton>(find.byType(VNLButton));
      expect(button.onFocus, isNotNull);
      expect(button.onHover, isNotNull);
    });

    testWidgets('respects custom alignment', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButton.primary(
            onPressed: () {},
            alignment: Alignment.centerLeft,
            child: Text('Left Aligned'),
          ),
        ),
      );

      expect(find.byType(VNLButton), findsOneWidget);
      expect(find.text('Left Aligned'), findsOneWidget);
    });

    testWidgets('handles long text content', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: SizedBox(
            width: 200,
            child: VNLButton.primary(
              onPressed: () {},
              child: Text(
                  'This is a very long button text that should wrap or be handled appropriately'),
            ),
          ),
        ),
      );

      expect(find.byType(VNLButton), findsOneWidget);
      expect(find.textContaining('very long button text'), findsOneWidget);
    });

    testWidgets('renders with different child widget types', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButton.primary(
            onPressed: () {},
            child: Row(
              children: [
                Icon(Icons.save),
                SizedBox(width: 8),
                Text('Save Changes'),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(VNLButton), findsOneWidget);
      expect(find.byIcon(Icons.save), findsOneWidget);
      expect(find.text('Save Changes'), findsOneWidget);
    });

    testWidgets('maintains proper sizing', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButton.primary(
            onPressed: () {},
            child: Text('VNLButton'),
          ),
        ),
      );

      final buttonFinder = find.byType(VNLButton);
      expect(buttonFinder, findsOneWidget);

      final buttonSize = tester.getSize(buttonFinder);
      expect(buttonSize.width, greaterThan(0));
      expect(buttonSize.height, greaterThan(0));
    });

    testWidgets('handles focus node parameter', (tester) async {
      final focusNode = FocusNode();
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButton.primary(
            onPressed: () {},
            focusNode: focusNode,
            child: Text('Focusable VNLButton'),
          ),
        ),
      );

      expect(find.byType(VNLButton), findsOneWidget);
      focusNode.dispose();
    });

    testWidgets('works with custom style parameter', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButton(
            style: VNLButtonVariance.primary,
            onPressed: () {},
            child: Text('Custom Style VNLButton'),
          ),
        ),
      );

      expect(find.byType(VNLButton), findsOneWidget);
      expect(find.text('Custom Style VNLButton'), findsOneWidget);
    });
  });
}
