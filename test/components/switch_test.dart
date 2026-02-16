import 'package:flutter_test/flutter_test.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('VNLSwitch', () {
    testWidgets('renders with initial value', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLSwitch(
            value: true,
            onChanged: (value) {},
          ),
        ),
      );

      expect(find.byType(VNLSwitch), findsOneWidget);
    });

    testWidgets('toggles value on tap', (tester) async {
      bool currentValue = false;
      await tester.pumpWidget(
        SimpleApp(
          child: StatefulBuilder(
            builder: (context, setState) {
              return VNLSwitch(
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

      await tester.tap(find.byType(VNLSwitch));
      await tester.pump();

      expect(currentValue, isTrue);

      await tester.tap(find.byType(VNLSwitch));
      await tester.pump();

      expect(currentValue, isFalse);
    });

    testWidgets('respects enabled state', (tester) async {
      bool currentValue = false;
      await tester.pumpWidget(
        SimpleApp(
          child: VNLSwitch(
            value: false,
            onChanged: (value) {
              currentValue = value;
            },
            enabled: false,
          ),
        ),
      );

      await tester.tap(find.byType(VNLSwitch));
      await tester.pump();

      expect(currentValue, isFalse);
    });
  });

  group('VNLControlledSwitch', () {
    testWidgets('works with controller', (tester) async {
      final controller = VNLSwitchController(false);
      await tester.pumpWidget(
        SimpleApp(
          child: VNLControlledSwitch(
            controller: controller,
          ),
        ),
      );

      expect(find.byType(VNLSwitch), findsOneWidget);

      controller.toggle();
      await tester.pump();

      // Verify visual state implicitly by checking if it didn't crash
      // and finding the widget.
      expect(find.byType(VNLSwitch), findsOneWidget);
    });

    testWidgets('works with initialValue', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLControlledSwitch(
            initialValue: true,
          ),
        ),
      );

      expect(find.byType(VNLSwitch), findsOneWidget);
    });
  });
}
