import 'package:flutter_test/flutter_test.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('VNLToggle', () {
    testWidgets('renders with initial value', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLToggle(
            value: true,
            onChanged: (value) {},
            child: const Text('VNLToggle Me'),
          ),
        ),
      );

      expect(find.byType(VNLToggle), findsOneWidget);
      expect(find.text('VNLToggle Me'), findsOneWidget);
    });

    testWidgets('toggles value on tap', (tester) async {
      bool currentValue = false;
      await tester.pumpWidget(
        SimpleApp(
          child: StatefulBuilder(
            builder: (context, setState) {
              return VNLToggle(
                value: currentValue,
                onChanged: (value) {
                  setState(() {
                    currentValue = value;
                  });
                },
                child: const Text('VNLToggle Me'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.byType(VNLToggle));
      await tester.pump();

      expect(currentValue, isTrue);

      await tester.tap(find.byType(VNLToggle));
      await tester.pump();

      expect(currentValue, isFalse);
    });

    testWidgets('respects enabled state', (tester) async {
      bool currentValue = false;
      await tester.pumpWidget(
        SimpleApp(
          child: VNLToggle(
            value: false,
            onChanged: (value) {
              currentValue = value;
            },
            enabled: false,
            child: const Text('VNLToggle Me'),
          ),
        ),
      );

      await tester.tap(find.byType(VNLToggle));
      await tester.pump();

      expect(currentValue, isFalse);
    });
  });

  group('VNLControlledToggle', () {
    testWidgets('works with controller', (tester) async {
      final controller = VNLToggleController(false);
      await tester.pumpWidget(
        SimpleApp(
          child: VNLControlledToggle(
            controller: controller,
            child: const Text('VNLToggle Me'),
          ),
        ),
      );

      expect(find.byType(VNLToggle), findsOneWidget);

      controller.toggle();
      await tester.pump();

      // Verify visual state implicitly
      expect(find.byType(VNLToggle), findsOneWidget);
    });

    testWidgets('works with initialValue', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLControlledToggle(
            initialValue: true,
            child: const Text('VNLToggle Me'),
          ),
        ),
      );

      expect(find.byType(VNLToggle), findsOneWidget);
    });
  });
}
