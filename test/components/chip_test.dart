import 'package:flutter_test/flutter_test.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('VNLChip', () {
    testWidgets('renders with child', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLChip(
            child: Text('VNLChip VNLLabel'),
          ),
        ),
      );

      expect(find.byType(VNLChip), findsOneWidget);
      expect(find.text('VNLChip VNLLabel'), findsOneWidget);
    });

    testWidgets('renders with leading and trailing widgets', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLChip(
            leading: Icon(Icons.star),
            trailing: Icon(Icons.close),
            child: Text('VNLChip VNLLabel'),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('VNLChip VNLLabel'), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('handles onPressed', (tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        SimpleApp(
          child: VNLChip(
            onPressed: () => pressed = true,
            child: Text('VNLClickable VNLChip'),
          ),
        ),
      );

      await tester.tap(find.byType(VNLChip));
      expect(pressed, isTrue);
    });

    testWidgets('applies custom style', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLChip(
            style: VNLButtonVariance.destructive,
            child: Text('Destructive VNLChip'),
          ),
        ),
      );

      expect(find.byType(VNLChip), findsOneWidget);
      // Visual style verification is limited in widget tests without golden files,
      // but we can verify no crash and widget presence.
    });
  });

  group('VNLChipButton', () {
    testWidgets('renders with child', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLChipButton(
            child: Icon(Icons.close),
          ),
        ),
      );

      expect(find.byType(VNLChipButton), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('handles onPressed', (tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        SimpleApp(
          child: VNLChipButton(
            onPressed: () => pressed = true,
            child: Icon(Icons.close),
          ),
        ),
      );

      await tester.tap(find.byType(VNLChipButton));
      expect(pressed, isTrue);
    });
  });
}
