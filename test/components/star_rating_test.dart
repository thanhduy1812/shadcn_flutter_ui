import 'package:flutter_test/flutter_test.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('VNLStarRating', () {
    testWidgets('renders with initial value', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLStarRating(
            value: 3.5,
            onChanged: (value) {},
          ),
        ),
      );

      expect(find.byType(VNLStarRating), findsOneWidget);
    });

    testWidgets('updates value on tap', (tester) async {
      double currentValue = 0.0;
      await tester.pumpWidget(
        SimpleApp(
          child: StatefulBuilder(
            builder: (context, setState) {
              return VNLStarRating(
                value: currentValue,
                onChanged: (value) {
                  setState(() {
                    currentValue = value;
                  });
                },
              );
            },
          ),
        ),
      );

      // Tap on the star rating.
      // Since we don't know exact coordinates, we tap center which should be around 2.5 or 3 stars
      await tester.tap(find.byType(VNLStarRating));
      await tester.pump();

      expect(currentValue, greaterThan(0.0));
    });

    testWidgets('respects enabled state', (tester) async {
      double currentValue = 0.0;
      await tester.pumpWidget(
        SimpleApp(
          child: VNLStarRating(
            value: 0.0,
            onChanged: (value) {
              currentValue = value;
            },
            enabled: false,
          ),
        ),
      );

      await tester.tap(find.byType(VNLStarRating));
      await tester.pump();

      expect(currentValue, equals(0.0));
    });
  });

  group('VNLControlledStarRating', () {
    testWidgets('works with controller', (tester) async {
      final controller = VNLStarRatingController(0.0);
      await tester.pumpWidget(
        SimpleApp(
          child: VNLControlledStarRating(
            controller: controller,
          ),
        ),
      );

      expect(find.byType(VNLStarRating), findsOneWidget);

      controller.value = 4.0;
      await tester.pump();

      // Verify visual state implicitly
      expect(find.byType(VNLStarRating), findsOneWidget);
    });

    testWidgets('works with initialValue', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLControlledStarRating(
            initialValue: 3.0,
          ),
        ),
      );

      expect(find.byType(VNLStarRating), findsOneWidget);
    });
  });
}
