import 'package:flutter/material.dart' as material;
import 'package:flutter_test/flutter_test.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('VNLActiveDotItem', () {
    testWidgets('renders with default properties', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLActiveDotItem(),
        ),
      );

      final container = tester.widget<Container>(find.descendant(
        of: find.byType(VNLActiveDotItem),
        matching: find.byType(Container),
      ));
      expect(container, isNotNull);
      expect(
          container.constraints?.maxWidth, 15.0); // Default size with scaling
      expect(container.constraints?.maxHeight, 15.0);
    });

    testWidgets('renders with custom size', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLActiveDotItem(size: 20),
        ),
      );

      final container = tester.widget<Container>(find.descendant(
        of: find.byType(VNLActiveDotItem),
        matching: find.byType(Container),
      ));
      expect(container.constraints?.maxWidth, 20);
      expect(container.constraints?.maxHeight, 20);
    });

    testWidgets('renders with custom color', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLActiveDotItem(color: material.Colors.red),
        ),
      );

      final container = tester.widget<Container>(find.descendant(
        of: find.byType(VNLActiveDotItem),
        matching: find.byType(Container),
      ));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, material.Colors.red);
    });

    testWidgets('renders with custom border radius', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLActiveDotItem(borderRadius: 8),
        ),
      );

      final container = tester.widget<Container>(find.descendant(
        of: find.byType(VNLActiveDotItem),
        matching: find.byType(Container),
      ));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.borderRadius, BorderRadius.circular(8));
    });

    testWidgets('renders with border when borderColor and borderWidth provided',
        (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLActiveDotItem(
            borderColor: material.Colors.blue,
            borderWidth: 2,
          ),
        ),
      );

      final container = tester.widget<Container>(find.descendant(
        of: find.byType(VNLActiveDotItem),
        matching: find.byType(Container),
      ));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.border, isNotNull);
      expect(decoration.border!.top.color, material.Colors.blue);
      expect(decoration.border!.top.width, 2);
    });

    testWidgets(
        'renders without border when borderColor or borderWidth missing',
        (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLActiveDotItem(borderColor: material.Colors.blue),
        ),
      );

      final container = tester.widget<Container>(find.descendant(
        of: find.byType(VNLActiveDotItem),
        matching: find.byType(Container),
      ));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.border, isNull);
    });

    testWidgets('uses theme values when widget values not provided',
        (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ComponentTheme<VNLDotIndicatorTheme>(
            data: VNLDotIndicatorTheme(
              size: 16,
              activeColor: material.Colors.green,
              borderRadius: 4,
            ),
            child: VNLActiveDotItem(),
          ),
        ),
      );

      final container = tester.widget<Container>(find.descendant(
        of: find.byType(VNLActiveDotItem),
        matching: find.byType(Container),
      ));
      expect(container.constraints?.maxWidth, 16);
      expect(container.constraints?.maxHeight, 16);

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, material.Colors.green);
      expect(decoration.borderRadius, BorderRadius.circular(4));
    });

    testWidgets('widget values override theme values', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ComponentTheme<VNLDotIndicatorTheme>(
            data: VNLDotIndicatorTheme(
              size: 16,
              activeColor: material.Colors.green,
            ),
            child: VNLActiveDotItem(
              size: 24,
              color: material.Colors.red,
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.descendant(
        of: find.byType(VNLActiveDotItem),
        matching: find.byType(Container),
      ));
      expect(container.constraints?.maxWidth, 24);
      expect(container.constraints?.maxHeight, 24);

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, material.Colors.red);
    });

    testWidgets('handles null theme gracefully', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLActiveDotItem(),
        ),
      );

      final container = tester.widget<Container>(find.descendant(
        of: find.byType(VNLActiveDotItem),
        matching: find.byType(Container),
      ));
      expect(container, isNotNull);
      // Should use default values
      expect(container.constraints?.maxWidth, 15.0);
    });
  });
}
