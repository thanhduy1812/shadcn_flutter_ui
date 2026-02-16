import 'package:flutter_test/flutter_test.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';
import '../test_helper.dart';

void main() {
  group('VNLCardButton', () {
    testWidgets('renders with basic content', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLCardButton(
            onPressed: () {},
            child: const Text('Test VNLButton'),
          ),
        ),
      );

      expect(find.byType(VNLCardButton), findsOneWidget);
      expect(find.text('Test VNLButton'), findsOneWidget);
    });

    testWidgets('renders with leading and trailing widgets', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLCardButton(
            onPressed: () {},
            leading: const Icon(RadixIcons.star),
            trailing: const Icon(RadixIcons.arrowRight),
            child: const Text('Test VNLButton'),
          ),
        ),
      );

      expect(find.byType(VNLCardButton), findsOneWidget);
      expect(find.byIcon(RadixIcons.star), findsOneWidget);
      expect(find.byIcon(RadixIcons.arrowRight), findsOneWidget);
      expect(find.text('Test VNLButton'), findsOneWidget);
    });

    testWidgets('handles onPressed callback', (tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        SimpleApp(
          child: VNLCardButton(
            onPressed: () => pressed = true,
            child: const Text('Test VNLButton'),
          ),
        ),
      );

      await tester.tap(find.byType(VNLCardButton));
      await tester.pumpAndSettle();

      expect(pressed, isTrue);
    });

    testWidgets('is disabled when onPressed is null', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLCardButton(
            child: const Text('Test VNLButton'),
          ),
        ),
      );

      final button = tester.widget<VNLButton>(find.byType(VNLButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('is disabled when enabled is false', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLCardButton(
            onPressed: () {},
            enabled: false,
            child: const Text('Test VNLButton'),
          ),
        ),
      );

      final button = tester.widget<VNLButton>(find.byType(VNLButton));
      expect(button.enabled, isFalse);
    });

    testWidgets('applies different sizes correctly', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Row(
            children: [
              VNLCardButton(
                onPressed: () {},
                size: VNLButtonSize.small,
                child: const Text('Small'),
              ),
              VNLCardButton(
                onPressed: () {},
                size: VNLButtonSize.large,
                child: const Text('Large'),
              ),
            ],
          ),
        ),
      );

      final buttons = tester.widgetList<VNLButton>(find.byType(VNLButton));
      expect(buttons.length, equals(2));

      // Both should use VNLButtonStyle with card variance
      for (final button in buttons) {
        expect(button.style, isA<VNLButtonStyle>());
        final buttonStyle = button.style as VNLButtonStyle;
        expect(buttonStyle.variance, equals(VNLButtonVariance.card));
      }
    });

    testWidgets('applies different densities correctly', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Row(
            children: [
              VNLCardButton(
                onPressed: () {},
                density: ButtonDensity.compact,
                child: const Text('Compact'),
              ),
              VNLCardButton(
                onPressed: () {},
                density: ButtonDensity.comfortable,
                child: const Text('Comfortable'),
              ),
            ],
          ),
        ),
      );

      final buttons = tester.widgetList<VNLButton>(find.byType(VNLButton));
      expect(buttons.length, equals(2));

      // Both should use VNLButtonStyle with card variance
      for (final button in buttons) {
        expect(button.style, isA<VNLButtonStyle>());
        final buttonStyle = button.style as VNLButtonStyle;
        expect(buttonStyle.variance, equals(VNLButtonVariance.card));
      }
    });

    testWidgets('applies different shapes correctly', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Row(
            children: [
              VNLCardButton(
                onPressed: () {},
                shape: ButtonShape.rectangle,
                child: const Text('Rectangle'),
              ),
              VNLCardButton(
                onPressed: () {},
                shape: ButtonShape.circle,
                child: const Text('Circle'),
              ),
            ],
          ),
        ),
      );

      final buttons = tester.widgetList<VNLButton>(find.byType(VNLButton));
      expect(buttons.length, equals(2));

      // Both should use VNLButtonStyle with card variance
      for (final button in buttons) {
        expect(button.style, isA<VNLButtonStyle>());
        final buttonStyle = button.style as VNLButtonStyle;
        expect(buttonStyle.variance, equals(VNLButtonVariance.card));
      }
    });

    testWidgets('handles alignment correctly', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLCardButton(
            onPressed: () {},
            alignment: Alignment.centerLeft,
            child: const Text('Aligned Left'),
          ),
        ),
      );

      final button = tester.widget<VNLButton>(find.byType(VNLButton));
      expect(button.alignment, equals(Alignment.centerLeft));
    });

    testWidgets('handles focus node', (tester) async {
      final focusNode = FocusNode();

      await tester.pumpWidget(
        SimpleApp(
          child: VNLCardButton(
            onPressed: () {},
            focusNode: focusNode,
            child: const Text('Focusable'),
          ),
        ),
      );

      final button = tester.widget<VNLButton>(find.byType(VNLButton));
      expect(button.focusNode, equals(focusNode));
      focusNode.dispose();
    });

    testWidgets('handles disableTransition flag', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLCardButton(
            onPressed: () {},
            disableTransition: true,
            child: const Text('No Transition'),
          ),
        ),
      );

      final button = tester.widget<VNLButton>(find.byType(VNLButton));
      expect(button.disableTransition, isTrue);
    });

    testWidgets('handles enableFeedback flag', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLCardButton(
            onPressed: () {},
            enableFeedback: false,
            child: const Text('No Feedback'),
          ),
        ),
      );

      final button = tester.widget<VNLButton>(find.byType(VNLButton));
      expect(button.enableFeedback, isFalse);
    });
  });
}
