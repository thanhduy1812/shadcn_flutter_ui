import 'package:flutter/material.dart' as material;
import 'package:flutter_test/flutter_test.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('VNLColorInput', () {
    testWidgets('renders with initial value', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLColorInput(
            value: VNLColorDerivative.fromColor(material.Colors.red),
            onChanged: (value) {},
          ),
        ),
      );

      expect(find.byType(VNLColorInput), findsOneWidget);
      // Default is small box without label
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('shows label when showLabel is true', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLColorInput(
            value: VNLColorDerivative.fromColor(material.Colors.red),
            onChanged: (value) {},
            showLabel: true,
          ),
        ),
      );

      expect(find.text('#fff44336'), findsOneWidget);
    });

    testWidgets('respects enabled state', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLColorInput(
            value: VNLColorDerivative.fromColor(material.Colors.red),
            onChanged: (value) {},
            enabled: false,
          ),
        ),
      );

      final button = tester.widget<VNLOutlineButton>(find.descendant(
        of: find.byType(VNLColorInput),
        matching: find.byType(VNLOutlineButton),
      ));
      expect(button.enabled, isFalse);
    });

    testWidgets('opens popover on tap', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Center(
            child: VNLColorInput(
              value: VNLColorDerivative.fromColor(material.Colors.red),
              onChanged: (value) {},
              promptMode: PromptMode.popover,
              enabled: true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(VNLOutlineButton));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.byType(ColorPicker), findsOneWidget);
    });
  });

  group('VNLControlledColorInput', () {
    testWidgets('works with controller', (tester) async {
      final controller =
          VNLColorInputController(VNLColorDerivative.fromColor(material.Colors.red));
      await tester.pumpWidget(
        SimpleApp(
          child: VNLControlledColorInput(
            initialValue: VNLColorDerivative.fromColor(material.Colors.blue),
            controller: controller,
          ),
        ),
      );

      expect(find.byType(VNLColorInput), findsOneWidget);
      // Should use controller's value (red)
      final container = tester.widget<Container>(
        find.byKey(const Key('color_input_preview')),
      );
      final decoration = container.decoration as BoxDecoration;
      expect(
          decoration.color?.toARGB32(), equals(material.Colors.red.toARGB32()));

      // Update controller
      controller.setColor(material.Colors.green);
      await tester.pumpAndSettle();

      final container2 = tester.widget<Container>(
        find.byKey(const Key('color_input_preview')),
      );
      final decoration2 = container2.decoration as BoxDecoration;
      expect(decoration2.color?.toARGB32(),
          equals(material.Colors.green.toARGB32()));
    });

    testWidgets('works with initialValue', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLControlledColorInput(
            initialValue: VNLColorDerivative.fromColor(material.Colors.blue),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(VNLColorInput), findsOneWidget);
      final container = tester.widget<Container>(
        find.byKey(const Key('color_input_preview')),
      );
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color?.toARGB32(),
          equals(material.Colors.blue.toARGB32()));
    });
  });
}
