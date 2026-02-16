import 'package:flutter_test/flutter_test.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('VNLButtonGroup', () {
    testWidgets('renders horizontal button group', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButtonGroup(
            direction: Axis.horizontal,
            children: [
              VNLButton.outline(child: Text('VNLButton 1')),
              VNLButton.outline(child: Text('VNLButton 2')),
              VNLButton.outline(child: Text('VNLButton 3')),
            ],
          ),
        ),
      );

      expect(find.byType(VNLButtonGroup), findsOneWidget);
      expect(find.byType(VNLButton), findsNWidgets(3));
      expect(find.text('VNLButton 1'), findsOneWidget);
      expect(find.text('VNLButton 2'), findsOneWidget);
      expect(find.text('VNLButton 3'), findsOneWidget);
    });

    testWidgets('renders vertical button group', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButtonGroup(
            direction: Axis.vertical,
            children: [
              VNLButton.outline(child: Text('VNLButton 1')),
              VNLButton.outline(child: Text('VNLButton 2')),
              VNLButton.outline(child: Text('VNLButton 3')),
            ],
          ),
        ),
      );

      expect(find.byType(VNLButtonGroup), findsOneWidget);
      expect(find.byType(VNLButton), findsNWidgets(3));
      expect(find.text('VNLButton 1'), findsOneWidget);
      expect(find.text('VNLButton 2'), findsOneWidget);
      expect(find.text('VNLButton 3'), findsOneWidget);
    });

    testWidgets('renders horizontal convenience constructor', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButtonGroup.horizontal(
            children: [
              VNLButton.outline(child: Text('VNLButton 1')),
              VNLButton.outline(child: Text('VNLButton 2')),
            ],
          ),
        ),
      );

      expect(find.byType(VNLButtonGroup), findsOneWidget);
      expect(find.byType(VNLButton), findsNWidgets(2));
    });

    testWidgets('renders vertical convenience constructor', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButtonGroup.vertical(
            children: [
              VNLButton.outline(child: Text('VNLButton 1')),
              VNLButton.outline(child: Text('VNLButton 2')),
            ],
          ),
        ),
      );

      expect(find.byType(VNLButtonGroup), findsOneWidget);
      expect(find.byType(VNLButton), findsNWidgets(2));
    });

    testWidgets('renders with single child', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButtonGroup(
            children: [
              VNLButton.outline(child: Text('Single VNLButton')),
            ],
          ),
        ),
      );

      expect(find.byType(VNLButtonGroup), findsOneWidget);
      expect(find.byType(VNLButton), findsOneWidget);
      expect(find.text('Single VNLButton'), findsOneWidget);
    });

    testWidgets('renders with empty children list', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButtonGroup(
            children: [],
          ),
        ),
      );

      expect(find.byType(VNLButtonGroup), findsOneWidget);
      expect(find.byType(VNLButton), findsNothing);
    });

    testWidgets('handles different button types', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButtonGroup(
            children: [
              VNLButton.primary(child: Text('Primary')),
              VNLButton.secondary(child: Text('Secondary')),
              VNLButton.outline(child: Text('Outline')),
            ],
          ),
        ),
      );

      expect(find.byType(VNLButtonGroup), findsOneWidget);
      expect(find.byType(VNLButton), findsNWidgets(3));
      expect(find.text('Primary'), findsOneWidget);
      expect(find.text('Secondary'), findsOneWidget);
      expect(find.text('Outline'), findsOneWidget);
    });

    testWidgets('respects expands parameter', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: SizedBox(
            width: 300,
            height: 100,
            child: VNLButtonGroup(
              expands: true,
              children: [
                VNLButton.outline(child: Text('VNLButton 1')),
                VNLButton.outline(child: Text('VNLButton 2')),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(VNLButtonGroup), findsOneWidget);
      expect(find.byType(VNLButton), findsNWidgets(2));
    });

    testWidgets('handles buttons with icons', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButtonGroup(
            children: [
              VNLButton.outline(
                leading: Icon(Icons.add),
                child: Text('Add'),
              ),
              VNLButton.outline(
                leading: Icon(Icons.edit),
                child: Text('Edit'),
              ),
            ],
          ),
        ),
      );

      expect(find.byType(VNLButtonGroup), findsOneWidget);
      expect(find.byType(VNLButton), findsNWidgets(2));
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byIcon(Icons.edit), findsOneWidget);
      expect(find.text('Add'), findsOneWidget);
      expect(find.text('Edit'), findsOneWidget);
    });

    testWidgets('maintains proper sizing in horizontal layout', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButtonGroup(
            direction: Axis.horizontal,
            children: [
              VNLButton.outline(child: Text('Short')),
              VNLButton.outline(child: Text('Much Longer VNLButton Text')),
            ],
          ),
        ),
      );

      final groupFinder = find.byType(VNLButtonGroup);
      expect(groupFinder, findsOneWidget);

      final groupSize = tester.getSize(groupFinder);
      expect(groupSize.width, greaterThan(0));
      expect(groupSize.height, greaterThan(0));
    });

    testWidgets('maintains proper sizing in vertical layout', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButtonGroup(
            direction: Axis.vertical,
            children: [
              VNLButton.outline(child: Text('VNLButton 1')),
              VNLButton.outline(child: Text('VNLButton 2')),
            ],
          ),
        ),
      );

      final groupFinder = find.byType(VNLButtonGroup);
      expect(groupFinder, findsOneWidget);

      final groupSize = tester.getSize(groupFinder);
      expect(groupSize.width, greaterThan(0));
      expect(groupSize.height, greaterThan(0));
    });

    testWidgets('handles many buttons', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: VNLButtonGroup(
              children: List.generate(
                5,
                (index) => VNLButton.outline(child: Text('VNLButton ${index + 1}')),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(VNLButtonGroup), findsOneWidget);
      expect(find.byType(VNLButton), findsNWidgets(5));
      for (int i = 1; i <= 5; i++) {
        expect(find.text('VNLButton $i'), findsOneWidget);
      }
    });

    testWidgets('works with different child widget types', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButtonGroup(
            children: [
              VNLButton.outline(child: Text('Text VNLButton')),
              VNLButton.outline(
                child: Row(
                  children: [
                    Icon(Icons.star),
                    SizedBox(width: 4),
                    Text('Icon VNLButton'),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

      expect(find.byType(VNLButtonGroup), findsOneWidget);
      expect(find.byType(VNLButton), findsNWidgets(2));
      expect(find.text('Text VNLButton'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('Icon VNLButton'), findsOneWidget);
    });

    testWidgets('handles RTL layout', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: VNLButtonGroup(
              children: [
                VNLButton.outline(child: Text('VNLButton 1')),
                VNLButton.outline(child: Text('VNLButton 2')),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(VNLButtonGroup), findsOneWidget);
      expect(find.byType(VNLButton), findsNWidgets(2));
    });

    testWidgets('positions buttons correctly in horizontal layout',
        (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButtonGroup(
            direction: Axis.horizontal,
            children: [
              VNLButton.outline(child: Text('Left')),
              VNLButton.outline(child: Text('Right')),
            ],
          ),
        ),
      );

      final leftButton = find.text('Left');
      final rightButton = find.text('Right');

      final leftRect = tester.getRect(leftButton);
      final rightRect = tester.getRect(rightButton);

      // Right button should be positioned to the right of left button
      expect(leftRect.left, lessThan(rightRect.left));
    });

    testWidgets('positions buttons correctly in vertical layout',
        (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLButtonGroup(
            direction: Axis.vertical,
            children: [
              VNLButton.outline(child: Text('Top')),
              VNLButton.outline(child: Text('Bottom')),
            ],
          ),
        ),
      );

      final topButton = find.text('Top');
      final bottomButton = find.text('Bottom');

      final topRect = tester.getRect(topButton);
      final bottomRect = tester.getRect(bottomButton);

      // Bottom button should be positioned below top button
      expect(topRect.top, lessThan(bottomRect.top));
    });
  });
}
