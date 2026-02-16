import 'dart:ui';

import 'package:vnl_common_ui/vnl_ui.dart';

// Demonstrates a scrollable VNLTable hooked to VNLScrollableClient with frozen
// rows/columns and diagonal drag panning.

class TableExample3 extends StatefulWidget {
  const TableExample3({super.key});

  @override
  State<TableExample3> createState() => _TableExample3State();
}

class _TableExample3State extends State<TableExample3> {
  // Builds a bordered cell; amounts can be right-aligned by passing true.
  VNLTableCell buildCell(String text, [bool alignRight = false]) {
    final theme = Theme.of(context);
    return VNLTableCell(
      theme: VNLTableCellTheme(
        border: WidgetStatePropertyAll(
          Border.all(
            color: theme.colorScheme.border,
            strokeAlign: BorderSide.strokeAlignCenter,
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        alignment: alignRight ? Alignment.topRight : null,
        child: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad,
        },
        // Disable overscroll glow and bouncing to keep the table steady.
        overscroll: false,
      ),
      child: SizedBox(
        height: 400,
        child: VNLOutlinedContainer(
          child: VNLScrollableClient(
              // Allow simultaneous horizontal and vertical drags for panning.
              diagonalDragBehavior: DiagonalDragBehavior.free,
              builder: (context, offset, viewportSize, child) {
                return VNLTable(
                  // Hook the table's scroll offsets to the VNLScrollableClient.
                  horizontalOffset: offset.dx,
                  verticalOffset: offset.dy,
                  // The viewport tells the table how much content area is visible.
                  viewportSize: viewportSize,
                  // Fixed sizes for consistent cell dimensions.
                  defaultColumnWidth: const VNLFixedTableSize(150),
                  defaultRowHeight: const VNLFixedTableSize(40),
                  // Freeze the first and fourth rows, and the first and third columns.
                  // These rows/columns stay pinned while the rest scrolls.
                  frozenCells: const VNLFrozenTableData(
                    frozenRows: [
                      VNLTableRef(0),
                      VNLTableRef(3),
                    ],
                    frozenColumns: [
                      VNLTableRef(0),
                      VNLTableRef(2),
                    ],
                  ),
                  rows: [
                    VNLTableHeader(
                      cells: [
                        buildCell('Invoice'),
                        buildCell('Status'),
                        buildCell('Method'),
                        buildCell('Amount', true),
                        buildCell('Verification'),
                        buildCell('Last Updated'),
                      ],
                    ),
                    VNLTableRow(
                      cells: [
                        buildCell('INV001'),
                        buildCell('Paid'),
                        buildCell('Credit VNLCard'),
                        buildCell('\$250.00', true),
                        buildCell('Verified'),
                        buildCell('2 hours ago'),
                      ],
                    ),
                    VNLTableRow(
                      cells: [
                        buildCell('INV002'),
                        buildCell('Pending'),
                        buildCell('PayPal'),
                        buildCell('\$150.00', true),
                        buildCell('Pending'),
                        buildCell('1 day ago'),
                      ],
                    ),
                    VNLTableRow(
                      cells: [
                        buildCell('INV003'),
                        buildCell('Unpaid'),
                        buildCell('Bank Transfer'),
                        buildCell('\$350.00', true),
                        buildCell('Unverified'),
                        buildCell('1 week ago'),
                      ],
                    ),
                    VNLTableRow(
                      cells: [
                        buildCell('INV004'),
                        buildCell('Paid'),
                        buildCell('Credit VNLCard'),
                        buildCell('\$450.00', true),
                        buildCell('Verified'),
                        buildCell('2 weeks ago'),
                      ],
                    ),
                    VNLTableRow(
                      cells: [
                        buildCell('INV005'),
                        buildCell('Paid'),
                        buildCell('PayPal'),
                        buildCell('\$550.00', true),
                        buildCell('Verified'),
                        buildCell('3 weeks ago'),
                      ],
                    ),
                    VNLTableRow(
                      cells: [
                        buildCell('INV006'),
                        buildCell('Pending'),
                        buildCell('Bank Transfer'),
                        buildCell('\$200.00', true),
                        buildCell('Pending'),
                        buildCell('1 month ago'),
                      ],
                    ),
                    VNLTableRow(
                      cells: [
                        buildCell('INV007'),
                        buildCell('Unpaid'),
                        buildCell('Credit VNLCard'),
                        buildCell('\$300.00', true),
                        buildCell('Unverified'),
                        buildCell('1 year ago'),
                      ],
                    ),
                    VNLTableRow(
                      cells: [
                        buildCell('INV008'),
                        buildCell('Paid'),
                        buildCell('Credit VNLCard'),
                        buildCell('\$250.00', true),
                        buildCell('Verified'),
                        buildCell('2 hours ago'),
                      ],
                    ),
                    VNLTableRow(
                      cells: [
                        buildCell('INV009'),
                        buildCell('Pending'),
                        buildCell('PayPal'),
                        buildCell('\$150.00', true),
                        buildCell('Pending'),
                        buildCell('1 day ago'),
                      ],
                    ),
                    VNLTableRow(
                      cells: [
                        buildCell('INV010'),
                        buildCell('Unpaid'),
                        buildCell('Bank Transfer'),
                        buildCell('\$350.00', true),
                        buildCell('Unverified'),
                        buildCell('1 week ago'),
                      ],
                    ),
                    VNLTableRow(
                      cells: [
                        buildCell('INV011'),
                        buildCell('Paid'),
                        buildCell('Credit VNLCard'),
                        buildCell('\$450.00', true),
                        buildCell('Verified'),
                        buildCell('2 weeks ago'),
                      ],
                    ),
                    VNLTableRow(
                      cells: [
                        buildCell('INV012'),
                        buildCell('Paid'),
                        buildCell('PayPal'),
                        buildCell('\$550.00', true),
                        buildCell('Verified'),
                        buildCell('3 weeks ago'),
                      ],
                    ),
                    VNLTableRow(
                      cells: [
                        buildCell('INV013'),
                        buildCell('Pending'),
                        buildCell('Bank Transfer'),
                        buildCell('\$200.00', true),
                        buildCell('Pending'),
                        buildCell('1 month ago'),
                      ],
                    ),
                    VNLTableRow(
                      cells: [
                        buildCell('INV014'),
                        buildCell('Unpaid'),
                        buildCell('Credit VNLCard'),
                        buildCell('\$300.00', true),
                        buildCell('Unverified'),
                        buildCell('1 year ago'),
                      ],
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
