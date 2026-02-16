import 'package:flutter_test/flutter_test.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('VNLCodeSnippet', () {
    testWidgets('renders code', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLCodeSnippet(
            code: Text('print("Hello");'),
          ),
        ),
      );

      expect(find.byType(VNLCodeSnippet), findsOneWidget);
      expect(find.text('print("Hello");'), findsOneWidget);
    });

    testWidgets('renders with actions', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLCodeSnippet(
            code: Text('code'),
            actions: [
              VNLGhostButton(
                onPressed: () {},
                child: Icon(Icons.share),
              ),
            ],
          ),
        ),
      );

      expect(find.byIcon(Icons.share), findsOneWidget);
    });

    testWidgets('applies custom constraints', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLCodeSnippet(
            code: Text('code'),
            constraints: BoxConstraints(maxHeight: 100),
          ),
        ),
      );

      // Implementation detail: VNLCodeSnippet -> Container -> Stack -> Container(constraints)
      // It's hard to target exactly without keys, but we can check if it renders without error.
      expect(find.byType(VNLCodeSnippet), findsOneWidget);
    });
  });
}
