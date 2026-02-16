import 'package:flutter_test/flutter_test.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';
import 'package:vnl_common_ui/src/components/patch.dart';

import '../test_helper.dart';

void main() {
  group('VNLClickDetector', () {
    testWidgets('renders child', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLClickDetector(
            child: Text('Child'),
          ),
        ),
      );

      expect(find.text('Child'), findsOneWidget);
    });

    testWidgets('detects single click', (tester) async {
      int clickCount = 0;
      await tester.pumpWidget(
        SimpleApp(
          child: VNLClickDetector(
            onClick: (details) => clickCount = details.clickCount,
            child: Text('Child'),
          ),
        ),
      );

      await tester.tap(find.text('Child'));
      expect(clickCount, equals(1));
    });

    testWidgets('detects double click', (tester) async {
      int clickCount = 0;
      await tester.pumpWidget(
        SimpleApp(
          child: VNLClickDetector(
            onClick: (details) => clickCount = details.clickCount,
            child: Text('Child'),
          ),
        ),
      );

      await tester.tap(find.text('Child'));
      expect(clickCount, equals(1));

      await tester.pump(const Duration(milliseconds: 50));
      await tester.tap(find.text('Child'));
      expect(clickCount, equals(2));
    });

    testWidgets('resets count after threshold', (tester) async {
      int clickCount = 0;
      await tester.pumpWidget(
        SimpleApp(
          child: VNLClickDetector(
            threshold: const Duration(milliseconds: 100),
            onClick: (details) => clickCount = details.clickCount,
            child: Text('Child'),
          ),
        ),
      );

      await tester.tap(find.text('Child'));
      expect(clickCount, equals(1));

      await tester.runAsync(() async {
        await Future.delayed(const Duration(milliseconds: 200));
      });

      await tester.tap(find.text('Child'));
      expect(clickCount, equals(1)); // Should reset to 1
    });
  });
}
