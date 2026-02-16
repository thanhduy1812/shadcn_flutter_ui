import 'package:flutter_test/flutter_test.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('VNLAutoComplete', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAutoComplete(
            suggestions: [],
            child: VNLTextField(),
          ),
        ),
      );

      expect(find.byType(VNLAutoComplete), findsOneWidget);
      expect(find.byType(VNLTextField), findsOneWidget);
    });

    testWidgets('shows suggestions when provided', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAutoComplete(
            suggestions: ['Apple', 'Banana', 'Cherry'],
            child: VNLTextField(),
          ),
        ),
      );

      expect(find.byType(VNLAutoComplete), findsOneWidget);
      // Suggestions should be available but not visible until triggered
    });

    testWidgets('handles empty suggestions list', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAutoComplete(
            suggestions: [],
            child: VNLTextField(),
          ),
        ),
      );

      expect(find.byType(VNLAutoComplete), findsOneWidget);
      expect(find.byType(VNLTextField), findsOneWidget);
    });

    testWidgets('accepts custom popover constraints', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAutoComplete(
            suggestions: ['Test'],
            popoverConstraints: BoxConstraints(maxHeight: 200),
            child: VNLTextField(),
          ),
        ),
      );

      final autoComplete =
          tester.widget<VNLAutoComplete>(find.byType(VNLAutoComplete));
      expect(autoComplete.popoverConstraints, BoxConstraints(maxHeight: 200));
    });

    testWidgets('accepts custom popover width constraint', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAutoComplete(
            suggestions: ['Test'],
            popoverWidthConstraint: PopoverConstraint.anchorFixedSize,
            child: VNLTextField(),
          ),
        ),
      );

      final autoComplete =
          tester.widget<VNLAutoComplete>(find.byType(VNLAutoComplete));
      expect(autoComplete.popoverWidthConstraint,
          PopoverConstraint.anchorFixedSize);
    });

    testWidgets('accepts custom popover alignments', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAutoComplete(
            suggestions: ['Test'],
            popoverAnchorAlignment: AlignmentDirectional.topStart,
            popoverAlignment: AlignmentDirectional.bottomStart,
            child: VNLTextField(),
          ),
        ),
      );

      final autoComplete =
          tester.widget<VNLAutoComplete>(find.byType(VNLAutoComplete));
      expect(
          autoComplete.popoverAnchorAlignment, AlignmentDirectional.topStart);
      expect(autoComplete.popoverAlignment, AlignmentDirectional.bottomStart);
    });

    testWidgets('accepts custom mode', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAutoComplete(
            suggestions: ['Test'],
            mode: AutoCompleteMode.append,
            child: VNLTextField(),
          ),
        ),
      );

      final autoComplete =
          tester.widget<VNLAutoComplete>(find.byType(VNLAutoComplete));
      expect(autoComplete.mode, AutoCompleteMode.append);
    });

    testWidgets('accepts custom completer', (tester) async {
      String customCompleter(String suggestion) => '$suggestion!';

      await tester.pumpWidget(
        SimpleApp(
          child: VNLAutoComplete(
            suggestions: ['Test'],
            completer: customCompleter,
            child: VNLTextField(),
          ),
        ),
      );

      final autoComplete =
          tester.widget<VNLAutoComplete>(find.byType(VNLAutoComplete));
      expect(autoComplete.completer('Test'), 'Test!');
    });

    testWidgets('uses default completer when none provided', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAutoComplete(
            suggestions: ['Test'],
            child: VNLTextField(),
          ),
        ),
      );

      final autoComplete =
          tester.widget<VNLAutoComplete>(find.byType(VNLAutoComplete));
      expect(autoComplete.completer('Test'), 'Test');
    });

    testWidgets('works with VNLTextField input', (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        SimpleApp(
          child: VNLAutoComplete(
            suggestions: ['Apple', 'Banana'],
            child: VNLTextField(
              controller: controller,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(VNLTextField), 'A');
      await tester.pump();

      expect(controller.text, 'A');
      expect(find.byType(VNLAutoComplete), findsOneWidget);
    });

    testWidgets('handles large suggestions list', (tester) async {
      final suggestions = List.generate(100, (index) => 'Suggestion $index');

      await tester.pumpWidget(
        SimpleApp(
          child: VNLAutoComplete(
            suggestions: suggestions,
            child: VNLTextField(),
          ),
        ),
      );

      final autoComplete =
          tester.widget<VNLAutoComplete>(find.byType(VNLAutoComplete));
      expect(autoComplete.suggestions.length, 100);
    });

    testWidgets('maintains child widget properties', (tester) async {
      const hintText = 'Enter text here';

      await tester.pumpWidget(
        SimpleApp(
          child: VNLAutoComplete(
            suggestions: [],
            child: VNLTextField(
              placeholder: Text(hintText),
            ),
          ),
        ),
      );

      expect(find.text(hintText), findsOneWidget);
    });

    testWidgets('handles null optional parameters', (tester) async {
      await tester.pumpWidget(
        SimpleApp(
          child: VNLAutoComplete(
            suggestions: ['Test'],
            child: VNLTextField(),
          ),
        ),
      );

      final autoComplete =
          tester.widget<VNLAutoComplete>(find.byType(VNLAutoComplete));
      expect(autoComplete.popoverConstraints, null);
      expect(autoComplete.popoverWidthConstraint, null);
      expect(autoComplete.popoverAnchorAlignment, null);
      expect(autoComplete.popoverAlignment, null);
      expect(autoComplete.mode, null);
    });

    testWidgets('renders in RTL', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.rtl,
          child: SimpleApp(
            child: VNLAutoComplete(
              suggestions: ['Test'],
              child: VNLTextField(),
            ),
          ),
        ),
      );

      expect(find.byType(VNLAutoComplete), findsOneWidget);
      expect(find.byType(VNLTextField), findsOneWidget);
    });
  });
}
