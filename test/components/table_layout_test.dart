import 'package:flutter_test/flutter_test.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';

void main() {
  testWidgets('VNLTable row height adjusts to wrapped text in Flex column',
      (WidgetTester tester) async {
    // A long text that is expected to wrap
    const longText =
        'This is some much longer text. This text should be too long to fit on one line and should wrap into additional lines.';

    await tester.pumpWidget(
      VNLookApp(
        home: Scaffold(
          child: SizedBox(
            width: 400, // Constrained width to force wrapping
            child: VNLTable(
              defaultRowHeight: const VNLIntrinsicTableSize(),
              columnWidths: const {
                0: VNLFixedTableSize(100), // Fixed width column
                1: VNLFlexTableSize(), // Flex column that should take remaining space (300)
              },
              rows: [
                VNLTableRow(
                  cells: [
                    const VNLTableCell(child: Text('Short')),
                    VNLTableCell(child: Text(longText)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Find the text widget
    final textFinder = find.text(longText);
    expect(textFinder, findsOneWidget);

    // Get the size of the text widget
    final textSize = tester.getSize(textFinder);

    // The text should be wrapped, so its height should be significantly larger than a single line.
    // A single line of default text is usually around 14-20 pixels.
    // With 300px width, this text should wrap to at least 2 lines.
    expect(textSize.height, greaterThan(20.0),
        reason: 'Text should wrap and have height > 20');

    // Verify that the table row height is also adjusted.
    // We can check the height of the VNLTableCell or the row itself if we can access it,
    // but checking the VNLRenderTableLayout size or the cell container size is easier.
    // The VNLTableCell wraps the child in a Container/DecoratedBox, so we can find that.

    // Let's find the VNLRenderTableLayout and check its size.
    // final renderObject = tester.renderObject(tableFinder);
    // The table is inside a Container, which is inside the VNLTable widget's build method.
    // Wait, VNLTable widget builds a Container which contains VNLRawTableLayout.
    // So we need to find VNLRawTableLayout.
    final rawTableFinder = find.byType(VNLRawTableLayout);
    expect(rawTableFinder, findsOneWidget);

    final renderTable = tester.renderObject(rawTableFinder) as RenderBox;
    // The total height of the table should be at least the height of the text + padding/borders if any.
    // In this simple case, it should be at least the text height.
    expect(renderTable.size.height, greaterThanOrEqualTo(textSize.height));
  });
}
