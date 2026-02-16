import 'package:flutter_test/flutter_test.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('VNLAlertDialog', () {
    testWidgets('renders with title only', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAlertDialog(
            title: Text('VNLAlert Title'),
          ),
        ),
      );

      expect(find.byType(VNLAlertDialog), findsOneWidget);
      expect(find.text('VNLAlert Title'), findsOneWidget);
    });

    testWidgets('renders with title and content', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAlertDialog(
            title: Text('VNLAlert Title'),
            content: Text('VNLAlert content here'),
          ),
        ),
      );

      expect(find.byType(VNLAlertDialog), findsOneWidget);
      expect(find.text('VNLAlert Title'), findsOneWidget);
      expect(find.text('VNLAlert content here'), findsOneWidget);
    });

    testWidgets('renders with leading icon', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAlertDialog(
            leading: Icon(Icons.info),
            title: Text('Info VNLAlert'),
          ),
        ),
      );

      expect(find.byType(VNLAlertDialog), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.text('Info VNLAlert'), findsOneWidget);
    });

    testWidgets('renders with trailing widget', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAlertDialog(
            title: Text('VNLAlert with action'),
            trailing: Icon(Icons.close),
          ),
        ),
      );

      expect(find.byType(VNLAlertDialog), findsOneWidget);
      expect(find.text('VNLAlert with action'), findsOneWidget);
    });

    testWidgets('renders with actions', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAlertDialog(
            title: Text('Confirm Action'),
            content: Text('Are you sure?'),
            actions: [
              VNLButton.primary(child: Text('OK'), onPressed: () {}),
              VNLButton.secondary(child: Text('Cancel'), onPressed: () {}),
            ],
          ),
        ),
      );

      expect(find.byType(VNLAlertDialog), findsOneWidget);
      expect(find.byType(VNLButton), findsNWidgets(2));
      expect(find.text('OK'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('handles empty dialog', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAlertDialog(),
        ),
      );

      expect(find.byType(VNLAlertDialog), findsOneWidget);
      // Should render without crashing
    });

    testWidgets('applies custom padding', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAlertDialog(
            padding: EdgeInsets.all(40),
            title: Text('Padded Dialog'),
          ),
        ),
      );

      expect(find.byType(VNLAlertDialog), findsOneWidget);
      expect(find.text('Padded Dialog'), findsOneWidget);
    });

    testWidgets('renders complex layout', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAlertDialog(
            leading: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: const Color(0xFF2196F3),
                shape: BoxShape.circle,
              ),
              child: Center(child: Text('!')),
            ),
            title: Text('Warning'),
            content: Text('This is a warning message with more details.'),
            trailing: Icon(Icons.warning),
            actions: [
              VNLButton.outline(child: Text('Ignore'), onPressed: () {}),
              VNLButton.primary(child: Text('Acknowledge'), onPressed: () {}),
            ],
          ),
        ),
      );

      expect(find.byType(VNLAlertDialog), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
      expect(find.text('Warning'), findsOneWidget);
      expect(find.text('This is a warning message with more details.'),
          findsOneWidget);
      expect(find.byType(VNLButton), findsNWidgets(2));
    });

    testWidgets('uses VNLModalBackdrop and VNLModalContainer', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAlertDialog(
            title: Text('Modal Test'),
          ),
        ),
      );

      expect(find.byType(VNLModalBackdrop), findsOneWidget);
      expect(find.byType(VNLModalContainer), findsOneWidget);
    });
  });
}
