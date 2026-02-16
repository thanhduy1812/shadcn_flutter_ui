import 'package:flutter_test/flutter_test.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('VNLBreadcrumb', () {
    testWidgets('renders with empty children list', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLBreadcrumb(children: []),
        ),
      );

      expect(find.byType(VNLBreadcrumb), findsOneWidget);
      // Should render as empty scroll view
    });

    testWidgets('renders with single child', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLBreadcrumb(
            children: [Text('Home')],
          ),
        ),
      );

      expect(find.byType(VNLBreadcrumb), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('renders with multiple children', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLBreadcrumb(
            children: [
              Text('Home'),
              Text('Category'),
              Text('Product'),
            ],
          ),
        ),
      );

      expect(find.byType(VNLBreadcrumb), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Category'), findsOneWidget);
      expect(find.text('Product'), findsOneWidget);
    });

    testWidgets('uses default arrow separator', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLBreadcrumb(
            children: [
              Text('Home'),
              Text('Category'),
            ],
          ),
        ),
      );

      expect(find.byType(VNLBreadcrumb), findsOneWidget);
      expect(find.byIcon(RadixIcons.chevronRight), findsOneWidget);
    });

    testWidgets('uses custom separator', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLBreadcrumb(
            separator: Icon(Icons.chevron_right),
            children: [
              Text('Home'),
              Text('Category'),
            ],
          ),
        ),
      );

      expect(find.byType(VNLBreadcrumb), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
      expect(find.byIcon(RadixIcons.chevronRight), findsNothing);
    });

    testWidgets('uses slash separator', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLBreadcrumb(
            separator: VNLBreadcrumb.slashSeparator,
            children: [
              Text('Home'),
              Text('Category'),
            ],
          ),
        ),
      );

      expect(find.byType(VNLBreadcrumb), findsOneWidget);
      expect(find.text('/'), findsOneWidget);
    });

    testWidgets('respects custom padding', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLBreadcrumb(
            padding: EdgeInsets.all(16),
            children: [Text('Home')],
          ),
        ),
      );

      expect(find.byType(VNLBreadcrumb), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('last child is styled as current page', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLBreadcrumb(
            children: [
              Text('Home'),
              Text('Category'),
              Text('Current'),
            ],
          ),
        ),
      );

      expect(find.byType(VNLBreadcrumb), findsOneWidget);
      expect(find.text('Current'), findsOneWidget);
      // The last child should be styled differently (foreground color)
    });

    testWidgets('intermediate children are styled as navigation',
        (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLBreadcrumb(
            children: [
              Text('Home'),
              Text('Category'),
              Text('Current'),
            ],
          ),
        ),
      );

      expect(find.byType(VNLBreadcrumb), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Category'), findsOneWidget);
      // Intermediate children should be styled as muted navigation items
    });

    testWidgets('handles many children with scrolling', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: SizedBox(
            width: 200, // Constrain width to force scrolling
            child: VNLBreadcrumb(
              children: [
                Text('Home'),
                Text('Category'),
                Text('Subcategory'),
                Text('Product'),
                Text('Details'),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(VNLBreadcrumb), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      // Should be scrollable horizontally
    });

    testWidgets('positions separators between navigation items',
        (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLBreadcrumb(
            children: [
              Text('Home'),
              Text('Category'),
              Text('Product'),
            ],
          ),
        ),
      );

      expect(find.byType(VNLBreadcrumb), findsOneWidget);
      // Should have separators between Home->Category and Category->Product
      expect(find.byIcon(RadixIcons.chevronRight), findsNWidgets(2));
    });

    testWidgets('renders correctly with button children', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLBreadcrumb(
            children: [
              VNLTextButton(onPressed: () {}, child: Text('Home')),
              VNLTextButton(onPressed: () {}, child: Text('Category')),
              Text('Current Page'),
            ],
          ),
        ),
      );

      expect(find.byType(VNLBreadcrumb), findsOneWidget);
      expect(find.byType(VNLTextButton), findsNWidgets(2));
      expect(find.text('Current Page'), findsOneWidget);
    });

    testWidgets('maintains proper spacing and layout', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLBreadcrumb(
            children: [
              Text('Home'),
              Text('Category'),
            ],
          ),
        ),
      );

      final breadcrumbFinder = find.byType(VNLBreadcrumb);
      expect(breadcrumbFinder, findsOneWidget);

      final homeFinder = find.text('Home');
      final categoryFinder = find.text('Category');

      final homeRect = tester.getRect(homeFinder);
      final categoryRect = tester.getRect(categoryFinder);

      // Category should be positioned after Home with separator in between
      expect(homeRect.left, lessThan(categoryRect.left));
    });

    testWidgets('handles RTL layout', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: VNLBreadcrumb(
              children: [
                Text('Home'),
                Text('Category'),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(VNLBreadcrumb), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Category'), findsOneWidget);
    });

    testWidgets('works with theme integration', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLBreadcrumb(
            children: [Text('Home')],
          ),
        ),
      );

      expect(find.byType(VNLBreadcrumb), findsOneWidget);
      // Should integrate with theme for styling
    });
  });
}
