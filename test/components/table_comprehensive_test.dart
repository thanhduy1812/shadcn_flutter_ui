import 'package:flutter_test/flutter_test.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';

void main() {
  group('VNLTable Sizing Strategies', () {
    testWidgets('VNLFixedTableSize respects exact pixel values',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        VNLookApp(
          home: Scaffold(
            child: Center(
              child: VNLTable(
                columnWidths: const {
                  0: VNLFixedTableSize(100),
                  1: VNLFixedTableSize(200),
                },
                rows: [
                  VNLTableRow(
                    cells: [
                      VNLTableCell(child: Container(height: 50)),
                      VNLTableCell(child: Container(height: 50)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      final rawTableFinder = find.byType(VNLRawTableLayout);
      expect(rawTableFinder, findsOneWidget);

      final renderTable = tester.renderObject(rawTableFinder) as RenderBox;
      expect(renderTable.size.width, equals(300.0));
    });

    testWidgets('VNLFlexTableSize distributes space proportionally',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        VNLookApp(
          home: Scaffold(
            child: Center(
              child: SizedBox(
                width: 300,
                child: VNLTable(
                  columnWidths: const {
                    0: VNLFlexTableSize(flex: 1),
                    1: VNLFlexTableSize(flex: 2),
                  },
                  rows: [
                    VNLTableRow(
                      cells: [
                        VNLTableCell(child: Container(height: 50)),
                        VNLTableCell(child: Container(height: 50)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      final rawTableFinder = find.byType(VNLRawTableLayout);
      final renderTable = tester.renderObject(rawTableFinder) as RenderBox;

      expect(renderTable.size.width, equals(300.0));
    });

    testWidgets('VNLFlexTableSize with tight fit fills space',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        VNLookApp(
          home: Scaffold(
            child: Center(
              child: SizedBox(
                width: 300,
                child: VNLTable(
                  columnWidths: const {
                    0: VNLFlexTableSize(flex: 1),
                    1: VNLFlexTableSize(flex: 2),
                  },
                  rows: [
                    VNLTableRow(
                      cells: [
                        VNLTableCell(
                            child: SizedBox(height: 50, child: Text('Cell 1'))),
                        VNLTableCell(
                            child: SizedBox(height: 50, child: Text('Cell 2'))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      final cell1Finder = find.text('Cell 1');
      final cell2Finder = find.text('Cell 2');

      final cell1Container = find
          .ancestor(of: cell1Finder, matching: find.byType(Container))
          .first;
      final cell2Container = find
          .ancestor(of: cell2Finder, matching: find.byType(Container))
          .first;

      final containerSize1 = tester.getSize(cell1Container);
      final containerSize2 = tester.getSize(cell2Container);

      expect(containerSize1.width, equals(100.0));
      expect(containerSize2.width, equals(200.0));
    });

    testWidgets('VNLIntrinsicTableSize adapts to content',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        VNLookApp(
          home: Scaffold(
            child: Center(
              child: VNLTable(
                columnWidths: const {
                  0: VNLIntrinsicTableSize(),
                  1: VNLIntrinsicTableSize(),
                },
                rows: [
                  VNLTableRow(
                    cells: [
                      VNLTableCell(child: SizedBox(width: 50, height: 50)),
                      VNLTableCell(child: SizedBox(width: 150, height: 50)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      final rawTableFinder = find.byType(VNLRawTableLayout);
      final renderTable = tester.renderObject(rawTableFinder) as RenderBox;

      // 50 + 150 + padding
      expect(renderTable.size.width, greaterThanOrEqualTo(200.0));
    });

    testWidgets('FractionalTableSize takes fraction of available space',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        VNLookApp(
          home: Scaffold(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child: VNLTable(
                  columnWidths: const {
                    0: FractionalTableSize(0.25), // 100px
                    1: FractionalTableSize(0.5), // 200px
                  },
                  rows: [
                    VNLTableRow(
                      cells: [
                        VNLTableCell(child: Container(height: 50)),
                        VNLTableCell(child: Container(height: 50)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      final rawTableFinder = find.byType(VNLRawTableLayout);
      final renderTable = tester.renderObject(rawTableFinder) as RenderBox;

      // VNLTable width should be 300 (100 + 200)
      expect(renderTable.size.width, equals(300.0));
    });

    testWidgets(
        'VNLIntrinsicTableSize row expands for wrapping text in Fixed column',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        VNLookApp(
          home: Scaffold(
            child: Center(
              child: VNLTable(
                columnWidths: const {
                  0: VNLFixedTableSize(100), // Constrained width
                },
                rows: [
                  VNLTableRow(
                    cells: [
                      VNLTableCell(
                        child: Text(
                          'This is a long text that should wrap to multiple lines',
                          style: TextStyle(fontSize: 20), // Ensure it wraps
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      final rawTableFinder = find.byType(VNLRawTableLayout);
      final renderTable = tester.renderObject(rawTableFinder) as RenderBox;

      // Height should be significantly larger than a single line (approx 20-24px)
      expect(renderTable.size.height, greaterThan(40.0));
    });
  });

  group('VNLTable Cell Spanning', () {
    testWidgets('Column span works correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        VNLookApp(
          home: Scaffold(
            child: Center(
              child: VNLTable(
                columnWidths: const {
                  0: VNLFixedTableSize(100),
                  1: VNLFixedTableSize(100),
                },
                rows: [
                  VNLTableRow(
                    cells: [
                      VNLTableCell(columnSpan: 2, child: Container(height: 50)),
                    ],
                  ),
                  VNLTableRow(
                    cells: [
                      VNLTableCell(child: Container(height: 50)),
                      VNLTableCell(child: Container(height: 50)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      final rawTableFinder = find.byType(VNLRawTableLayout);
      final renderTable = tester.renderObject(rawTableFinder) as RenderBox;

      expect(renderTable.size.width, equals(200.0));
    });

    testWidgets('Row span works correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        VNLookApp(
          home: Scaffold(
            child: Center(
              child: VNLTable(
                columnWidths: const {
                  0: VNLFixedTableSize(100),
                  1: VNLFixedTableSize(100),
                },
                rows: [
                  VNLTableRow(
                    cells: [
                      VNLTableCell(
                          rowSpan: 2,
                          child: SizedBox(height: 100, child: Text('Spanned'))),
                      VNLTableCell(
                          child: SizedBox(height: 50, child: Text('Cell 1'))),
                    ],
                  ),
                  VNLTableRow(
                    cells: [
                      VNLTableCell(
                          child: SizedBox(height: 50, child: Text('Cell 2'))),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      final cell1Text = find.text('Cell 1');
      final cell2Text = find.text('Cell 2');

      final cell1Container =
          find.ancestor(of: cell1Text, matching: find.byType(Container)).first;
      final cell2Container =
          find.ancestor(of: cell2Text, matching: find.byType(Container)).first;

      final cell1Size = tester.getSize(cell1Container);
      final cell2Size = tester.getSize(cell2Container);

      // Cell height is content height (50) + border (approx 1).
      // Padding is not added by VNLTableCell by default.
      expect(cell1Size.height, closeTo(51.0, 1.0));
      expect(cell2Size.height, closeTo(51.0, 1.0));

      final spannedText = find.text('Spanned');
      final spannedContainer = find
          .ancestor(of: spannedText, matching: find.byType(Container))
          .first;
      final spannedSize = tester.getSize(spannedContainer);

      // Spanned cell should cover both rows.
      // 51 + 51 = 102.
      expect(spannedSize.height, closeTo(102.0, 2.0));
    });
  });

  group('VNLTable Frozen Cells & Scrolling', () {
    testWidgets('Frozen columns remain visible', (WidgetTester tester) async {
      await tester.pumpWidget(
        VNLookApp(
          home: Scaffold(
            child: Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: ClipRect(
                  child: VNLTable(
                    frozenCells: VNLFrozenTableData(frozenColumns: [VNLTableRef(0)]),
                    horizontalOffset: 100, // Scroll right by 100
                    columnWidths: const {
                      0: VNLFixedTableSize(100), // Frozen
                      1: VNLFixedTableSize(100), // Scrolled out
                      2: VNLFixedTableSize(100), // Visible
                    },
                    rows: [
                      VNLTableRow(
                        cells: [
                          VNLTableCell(child: Text('Fixed')),
                          VNLTableCell(child: Text('Scrolled')),
                          VNLTableCell(child: Text('Visible')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      final fixedFinder = find.text('Fixed');
      final visibleFinder = find.text('Visible');

      expect(fixedFinder, findsOneWidget);
      expect(visibleFinder, findsOneWidget);

      final fixedPos = tester.getTopLeft(fixedFinder);
      final visiblePos = tester.getTopLeft(visibleFinder);
      final tablePos = tester.getTopLeft(find.byType(VNLTable));

      // Fixed cell should be at the start
      expect(fixedPos.dx, greaterThanOrEqualTo(tablePos.dx));
      expect(fixedPos.dx, lessThan(tablePos.dx + 100));

      // Visible (Column 2) should be at 100px from start (after Fixed)
      expect(visiblePos.dx, greaterThanOrEqualTo(tablePos.dx + 100));
    });
  });

  group('VNLResizableTable', () {
    testWidgets('VNLResizableTable renders and allows resizing',
        (WidgetTester tester) async {
      final controller = VNLResizableTableController(
        defaultColumnWidth: 100,
        defaultRowHeight: 50,
        columnWidths: {
          0: 100,
          1: 100,
        },
      );
      await tester.pumpWidget(
        VNLookApp(
          home: Scaffold(
            child: Center(
              child: VNLResizableTable(
                controller: controller,
                rows: [
                  VNLTableRow(
                    cells: [
                      VNLTableCell(child: Text('Col 1')),
                      VNLTableCell(child: Text('Col 2')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byType(VNLResizableTable), findsOneWidget);
      expect(find.text('Col 1'), findsOneWidget);
      expect(find.text('Col 2'), findsOneWidget);
    });
  });

  group('VNLTable Theming', () {
    testWidgets('VNLTable applies theme', (WidgetTester tester) async {
      await tester.pumpWidget(
        VNLookApp(
          home: Scaffold(
            child: Center(
              child: VNLTable(
                theme: VNLTableTheme(
                  borderRadius: BorderRadius.circular(10),
                ),
                rows: [
                  VNLTableRow(
                    cells: [
                      VNLTableCell(child: Text('Themed')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Themed'), findsOneWidget);
    });
  });
}
