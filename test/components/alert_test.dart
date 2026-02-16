import 'package:flutter_test/flutter_test.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('VNLAlert', () {
    testWidgets('renders with title only', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAlert(
            title: Text('VNLAlert Title'),
          ),
        ),
      );

      expect(find.byType(VNLAlert), findsOneWidget);
      expect(find.text('VNLAlert Title'), findsOneWidget);
    });

    testWidgets('renders with title and content', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAlert(
            title: Text('VNLAlert Title'),
            content: Text('VNLAlert content here'),
          ),
        ),
      );

      expect(find.byType(VNLAlert), findsOneWidget);
      expect(find.text('VNLAlert Title'), findsOneWidget);
      expect(find.text('VNLAlert content here'), findsOneWidget);
    });

    testWidgets('renders with leading icon', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAlert(
            leading: Icon(Icons.info),
            title: Text('Info VNLAlert'),
          ),
        ),
      );

      expect(find.byType(VNLAlert), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.text('Info VNLAlert'), findsOneWidget);
    });

    testWidgets('renders with trailing widget', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAlert(
            title: Text('VNLAlert with action'),
            trailing: VNLButton.primary(
              child: Icon(Icons.close),
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(VNLAlert), findsOneWidget);
      expect(find.byType(VNLButton), findsOneWidget);
      expect(find.text('VNLAlert with action'), findsOneWidget);
    });

    testWidgets('renders in destructive mode', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAlert.destructive(
            leading: Icon(Icons.error),
            title: Text('Error VNLAlert'),
            content: Text('Something went wrong'),
          ),
        ),
      );

      expect(find.byType(VNLAlert), findsOneWidget);
      expect(find.text('Error VNLAlert'), findsOneWidget);
      expect(find.text('Something went wrong'), findsOneWidget);
      // Destructive styling would be verified in visual tests
    });

    testWidgets('applies theme correctly', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: ComponentTheme<VNLAlertTheme>(
            data: VNLAlertTheme(
              padding: EdgeInsets.all(20),
            ),
            child: VNLAlert(
              title: Text('Themed VNLAlert'),
            ),
          ),
        ),
      );

      expect(find.byType(VNLAlert), findsOneWidget);
      expect(find.text('Themed VNLAlert'), findsOneWidget);
      // Theme application would be verified in golden tests or more detailed checks
    });

    testWidgets('handles empty alert', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAlert(),
        ),
      );

      expect(find.byType(VNLAlert), findsOneWidget);
      // Should render without crashing
    });

    testWidgets('supports complex content', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAlert(
            leading: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: const Color(0xFF2196F3),
                shape: BoxShape.circle,
              ),
              child: Center(child: Text('A')),
            ),
            title: Text('Complex VNLAlert'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Line 1'),
                Text('Line 2'),
              ],
            ),
            trailing: Row(
              children: [
                VNLButton.primary(child: Text('OK'), onPressed: () {}),
                VNLButton.secondary(child: Text('Cancel'), onPressed: () {}),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(VNLAlert), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
      expect(find.text('Complex VNLAlert'), findsOneWidget);
      expect(find.text('Line 1'), findsOneWidget);
      expect(find.text('Line 2'), findsOneWidget);
      expect(find.byType(VNLButton), findsNWidgets(2));
    });
  });
}
