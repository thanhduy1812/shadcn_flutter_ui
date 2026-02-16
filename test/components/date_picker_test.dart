import 'package:flutter_test/flutter_test.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('VNLDatePicker', () {
    testWidgets('renders with initial value', (tester) async {
      final date = DateTime(2023, 1, 1);
      await tester.pumpWidget(
        SimpleApp(
          child: VNLDatePicker(
            value: date,
            onChanged: (value) {},
          ),
        ),
      );

      expect(find.byType(VNLDatePicker), findsOneWidget);
      expect(find.text('January 1, 2023'), findsOneWidget);
    });

    testWidgets('shows placeholder when value is null', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLDatePicker(
            value: null,
            onChanged: (value) {},
            placeholder: const Text('Select Date'),
          ),
        ),
      );

      expect(find.text('Select Date'), findsOneWidget);
    });

    testWidgets('opens picker on tap', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLDatePicker(
            value: null,
            onChanged: (value) {},
            mode: PromptMode.dialog, // Use dialog for easier testing
          ),
        ),
      );

      await tester.tap(find.byType(VNLDatePicker));
      await tester.pumpAndSettle();

      expect(find.byType(VNLDatePickerDialog), findsOneWidget);
    });
  });

  group('VNLControlledDatePicker', () {
    testWidgets('works with controller', (tester) async {
      final date = DateTime(2023, 1, 1);
      final controller = VNLDatePickerController(date);

      await tester.pumpWidget(
        SimpleApp(
          child: VNLControlledDatePicker(
            controller: controller,
          ),
        ),
      );

      expect(find.text('January 1, 2023'), findsOneWidget);

      controller.value = DateTime(2023, 2, 1);
      await tester.pump();

      expect(find.text('February 1, 2023'), findsOneWidget);
    });

    testWidgets('works with initialValue', (tester) async {
      final date = DateTime(2023, 1, 1);
      await tester.pumpWidget(
        SimpleApp(
          child: VNLControlledDatePicker(
            initialValue: date,
          ),
        ),
      );

      expect(find.text('January 1, 2023'), findsOneWidget);
    });
  });
}
