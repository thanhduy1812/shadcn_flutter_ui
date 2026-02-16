import 'package:flutter_test/flutter_test.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('VNLDateInput', () {
    testWidgets('renders with initial value', (tester) async {
      final date = DateTime(2023, 1, 1);
      await tester.pumpWidget(
        SimpleApp(
          child: VNLDateInput(
            initialValue: date,
            onChanged: (value) {},
          ),
        ),
      );

      expect(find.byType(VNLDateInput), findsOneWidget);

      // VNLDateInput renders text fields for parts.
      // With unpadded implementation: 2023, 1, 1 -> 1 1 2023
      expect(find.text('1'), findsAtLeastNWidgets(2)); // Month and Day
      expect(find.text('2023'), findsOneWidget);
    });

    testWidgets('updates value on input', (tester) async {
      DateTime? currentDate;
      await tester.pumpWidget(
        SimpleApp(
          child: VNLDateInput(
            initialValue: null,
            onChanged: (value) {
              currentDate = value;
            },
          ),
        ),
      );

      expect(find.byType(VNLDateInput), findsOneWidget);

      // Enter year
      await tester.enterText(find.byType(VNLTextField).last, '2023');
      await tester.pump();

      // Enter month
      await tester.enterText(find.byType(VNLTextField).first, '1');
      await tester.pump();

      // Enter day
      await tester.enterText(find.byType(VNLTextField).at(1), '1');
      await tester.pump();

      expect(currentDate, isNotNull);
      expect(currentDate?.year, equals(2023));
      expect(currentDate?.month, equals(1));
      expect(currentDate?.day, equals(1));
    });
  });
}
