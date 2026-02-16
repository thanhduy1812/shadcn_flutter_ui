import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('VNLCommand', () {
    testWidgets('renders with search field', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLCommand(
            debounceDuration: Duration.zero,
            builder: (context, query) async* {
              yield [];
            },
          ),
        ),
      );
      await tester.pump(); // Process microtasks
      await tester.pump(
          const Duration(milliseconds: 10)); // Process zero-duration timers

      expect(find.byType(VNLTextField), findsOneWidget);
      expect(find.byIcon(LucideIcons.search), findsOneWidget);
    });

    testWidgets('shows results from builder', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLCommand(
            debounceDuration: Duration.zero,
            builder: (context, query) async* {
              yield [
                VNLCommandItem(title: const Text('Item 1'), onTap: () {}),
                VNLCommandItem(title: const Text('Item 2'), onTap: () {}),
              ];
            },
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 10)); // Debounce
      await tester.pump(const Duration(milliseconds: 500)); // Animations

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
    });

    testWidgets('filters results based on query', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLCommand(
            debounceDuration: Duration.zero,
            builder: (context, query) async* {
              if (query == null || query.isEmpty) {
                yield [
                  VNLCommandItem(title: const Text('Apple'), onTap: () {}),
                  VNLCommandItem(title: const Text('Banana'), onTap: () {}),
                ];
              } else {
                if ('Apple'.contains(query)) {
                  yield [VNLCommandItem(title: const Text('Apple'), onTap: () {})];
                } else if ('Banana'.contains(query)) {
                  yield [
                    VNLCommandItem(title: const Text('Banana'), onTap: () {})
                  ];
                } else {
                  yield [];
                }
              }
            },
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 10));
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Banana'), findsOneWidget);

      await tester.enterText(find.byType(VNLTextField), 'App');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 10));
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Banana'), findsNothing);
    });

    testWidgets('shows empty state when no results', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLCommand(
            debounceDuration: Duration.zero,
            builder: (context, query) async* {
              yield [];
            },
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 10));
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.byType(VNLCommandEmpty), findsOneWidget);
    });

    testWidgets('handles keyboard navigation', (tester) async {
      bool item1Tapped = false;
      bool item2Tapped = false;

      await tester.pumpWidget(
        SimpleApp(
          child: VNLCommand(
            debounceDuration: Duration.zero,
            builder: (context, query) async* {
              yield [
                VNLCommandItem(
                    title: const Text('Item 1'),
                    onTap: () => item1Tapped = true),
                VNLCommandItem(
                    title: const Text('Item 2'),
                    onTap: () => item2Tapped = true),
              ];
            },
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 10));
      await tester.pump(const Duration(milliseconds: 500));

      // Focus search field
      await tester.tap(find.byType(VNLTextField));
      await tester.pump();

      // Navigate down to Item 1
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pump(const Duration(milliseconds: 100));

      // Navigate down to Item 2
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pump(const Duration(milliseconds: 100));

      // Select Item 2
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump(const Duration(milliseconds: 100));

      expect(item2Tapped, isTrue);
      expect(item1Tapped, isFalse);
    });

    testWidgets('VNLCommandCategory renders children', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLCommand(
            debounceDuration: Duration.zero,
            builder: (context, query) async* {
              yield [
                VNLCommandCategory(
                  title: const Text('Category 1'),
                  children: [
                    VNLCommandItem(title: const Text('Item 1'), onTap: () {}),
                  ],
                ),
              ];
            },
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 10));
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Category 1'), findsOneWidget);
      expect(find.text('Item 1'), findsOneWidget);
    });
  });
}
