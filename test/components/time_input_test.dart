import 'package:flutter_test/flutter_test.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('VNLTimeInput', () {
    testWidgets('renders with initial value', (tester) async {
      final time = TimeOfDay(hour: 10, minute: 30);
      await tester.pumpWidget(
        SimpleApp(
          child: VNLTimeInput(
            initialValue: time,
            onChanged: (value) {},
          ),
        ),
      );

      expect(find.byType(VNLTimeInput), findsOneWidget);
      expect(find.text('10'), findsOneWidget);
      expect(find.text('30'), findsOneWidget);
    });

    testWidgets('updates value on input', (tester) async {
      TimeOfDay? currentTime;
      await tester.pumpWidget(
        SimpleApp(
          child: VNLTimeInput(
            initialValue: null,
            onChanged: (value) {
              currentTime = value;
            },
          ),
        ),
      );

      expect(find.byType(VNLTimeInput), findsOneWidget);

      // Enter hour
      await tester.enterText(find.byType(VNLTextField).first, '10');
      await tester.pump();

      // Enter minute
      await tester.enterText(find.byType(VNLTextField).last, '30');
      await tester.pump();

      expect(currentTime, isNotNull);
      expect(currentTime?.hour, equals(10));
      expect(currentTime?.minute, equals(30));
    });
  });
}
