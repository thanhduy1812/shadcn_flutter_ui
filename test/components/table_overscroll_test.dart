import 'package:flutter_test/flutter_test.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';

Widget buildApp({bool overscroll = false}) {
  return VNLookApp(
    home: Scaffold(
      child: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: VNLScrollableClient(
            diagonalDragBehavior: DiagonalDragBehavior.free,
            overscroll: overscroll,
            builder: (context, offset, viewportSize, child) {
              return VNLTable(
                horizontalOffset: offset.dx,
                verticalOffset: offset.dy,
                viewportSize: viewportSize,
                columnWidths: const {
                  0: VNLFixedTableSize(100),
                  1: VNLFixedTableSize(100),
                  2: VNLFixedTableSize(100),
                },
                frozenCells: VNLFrozenTableData(
                  frozenRows: [VNLTableRef(0)],
                  frozenColumns: [VNLTableRef(0)],
                ),
                rows: [
                  VNLTableRow(
                    cells: [
                      VNLTableCell(
                          child: SizedBox(
                              width: 100, height: 100, child: Text('R0 C0'))),
                      VNLTableCell(
                          child: SizedBox(
                              width: 100, height: 100, child: Text('R0 C1'))),
                      VNLTableCell(
                          child: SizedBox(
                              width: 100, height: 100, child: Text('R0 C2'))),
                    ],
                  ),
                  VNLTableRow(
                    cells: [
                      VNLTableCell(
                          child: SizedBox(
                              width: 100, height: 100, child: Text('R1 C0'))),
                      VNLTableCell(
                          child: SizedBox(
                              width: 100, height: 100, child: Text('R1 C1'))),
                      VNLTableCell(
                          child: SizedBox(
                              width: 100, height: 100, child: Text('R1 C2'))),
                    ],
                  ),
                  VNLTableRow(
                    cells: [
                      VNLTableCell(
                          child: SizedBox(
                              width: 100, height: 100, child: Text('R2 C0'))),
                      VNLTableCell(
                          child: SizedBox(
                              width: 100, height: 100, child: Text('R2 C1'))),
                      VNLTableCell(
                          child: SizedBox(
                              width: 100, height: 100, child: Text('R2 C2'))),
                    ],
                  ),
                  VNLTableRow(
                    cells: [
                      VNLTableCell(
                          child: SizedBox(
                              width: 100, height: 100, child: Text('R3 C0'))),
                      VNLTableCell(
                          child: SizedBox(
                              width: 100, height: 100, child: Text('R3 C1'))),
                      VNLTableCell(
                          child: SizedBox(
                              width: 100, height: 100, child: Text('R3 C2'))),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('VNLTable overscroll - Valid Range', (WidgetTester tester) async {
    await tester.pumpWidget(buildApp());
    final scrollableFinder = find.byType(VNLScrollableClient);
    final r0c0Finder = find.text('R0 C0');

    // Drag (-50, -50) should be within max scroll (100, 200)
    await tester.drag(scrollableFinder, const Offset(-50, -50));
    await tester.pump();

    var r0c0Pos = tester.getTopLeft(r0c0Finder);
    var scrollablePos = tester.getTopLeft(scrollableFinder);

    // Frozen cell (0,0) should stick to top-left of viewport
    expect(r0c0Pos, equals(scrollablePos));
  });

  testWidgets('VNLTable overscroll - End Overscroll', (WidgetTester tester) async {
    await tester.pumpWidget(buildApp());
    final scrollableFinder = find.byType(VNLScrollableClient);
    final r0c0Finder = find.text('R0 C0');

    // Scroll to end first
    await tester.drag(scrollableFinder, const Offset(-500, -500));
    await tester.pump();

    // Overscroll further (pull up-left)
    await tester.drag(scrollableFinder, const Offset(-50, -50));
    await tester.pump();

    var r0c0Pos = tester.getTopLeft(r0c0Finder);
    var scrollablePos = tester.getTopLeft(scrollableFinder);

    // Frozen cell should stick to top-left of viewport, even during overscroll
    expect(r0c0Pos, equals(scrollablePos));
  });

  testWidgets('VNLTable overscroll - Start Overscroll',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildApp());
    final scrollableFinder = find.byType(VNLScrollableClient);
    final r0c0Finder = find.text('R0 C0');

    // Overscroll at start (pull down-right)
    await tester.drag(scrollableFinder, const Offset(50, 50));
    await tester.pump();

    var r0c0Pos = tester.getTopLeft(r0c0Finder);
    var scrollablePos = tester.getTopLeft(scrollableFinder);

    // Frozen cell should stick to top-left of viewport, even during overscroll
    expect(r0c0Pos, equals(scrollablePos));
  });

  testWidgets('VNLTable overscroll disabled - Start Overscroll',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildApp(overscroll: false));
    final scrollableFinder = find.byType(VNLScrollableClient);
    final r0c0Finder = find.text('R0 C0');

    // Drag (50, 50) -> Start Overscroll (pulling down-right)
    await tester.drag(scrollableFinder, const Offset(50, 50));
    await tester.pump();

    final scrollablePos = tester.getTopLeft(scrollableFinder);
    final r0c0Pos = tester.getTopLeft(r0c0Finder);

    // Expect frozen cell to be at (0,0) relative to scrollable
    expect(r0c0Pos, equals(scrollablePos));
  });
}
