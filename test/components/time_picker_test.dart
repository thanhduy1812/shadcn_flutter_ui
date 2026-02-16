import 'package:flutter_test/flutter_test.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('VNLTimePicker', () {
    testWidgets('renders with initial value', (tester) async {
      const time = TimeOfDay(hour: 10, minute: 30);
      await tester.pumpWidget(
        SimpleApp(
          child: VNLTimePicker(
            value: time,
            onChanged: (value) {},
          ),
        ),
      );

      expect(find.byType(VNLTimePicker), findsOneWidget);
      expect(find.text('10:30 AM'), findsOneWidget);
    });

    testWidgets('shows placeholder when value is null', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLTimePicker(
            value: null,
            onChanged: (value) {},
            placeholder: const Text('Select Time'),
          ),
        ),
      );

      expect(find.text('Select Time'), findsOneWidget);
    });

    testWidgets('opens picker on tap', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLTimePicker(
            value: null,
            onChanged: (value) {},
            mode: PromptMode.dialog,
          ),
        ),
      );

      await tester.tap(find.byType(VNLTimePicker));
      await tester.pumpAndSettle();

      expect(find.byType(VNLTimePickerDialog), findsOneWidget);
    });
  });

  group('VNLControlledTimePicker', () {
    testWidgets('works with controller', (tester) async {
      const time = TimeOfDay(hour: 10, minute: 30);
      final controller = VNLTimePickerController(time);

      await tester.pumpWidget(
        SimpleApp(
          child: VNLControlledTimePicker(
            controller: controller,
          ),
        ),
      );

      expect(find.text('10:30 AM'), findsOneWidget);

      controller.value = const TimeOfDay(hour: 11, minute: 45);
      await tester.pump();

      expect(find.text('11:45 AM'), findsOneWidget);
    });

    testWidgets('works with initialValue', (tester) async {
      const time = TimeOfDay(hour: 10, minute: 30);
      await tester.pumpWidget(
        SimpleApp(
          child: VNLControlledTimePicker(
            initialValue: time,
          ),
        ),
      );

      expect(find.text('10:30 AM'), findsOneWidget);
    });
  });
}
