import 'package:flutter_test/flutter_test.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';

import '../test_helper.dart';

void main() {
  group('VNLCalendarGrid', () {
    testWidgets('renders calendar grid with data', (tester) async {
      final gridData = VNLCalendarGridData(month: 3, year: 2024);

      await tester.pumpWidget(
        SimpleApp(
          child: VNLCalendarGrid(
            data: gridData,
            itemBuilder: (item) => Container(
              alignment: Alignment.center,
              child: Text(item.date.day.toString()),
            ),
          ),
        ),
      );

      expect(find.byType(VNLCalendarGrid), findsOneWidget);
      // VNLCalendarGrid contains a Column
      expect(
          find.descendant(
              of: find.byType(VNLCalendarGrid), matching: find.byType(Column)),
          findsOneWidget);
    });

    testWidgets('renders weekday headers', (tester) async {
      final gridData = VNLCalendarGridData(month: 3, year: 2024);

      await tester.pumpWidget(
        SimpleApp(
          child: VNLCalendarGrid(
            data: gridData,
            itemBuilder: (item) => Container(
              alignment: Alignment.center,
              child: Text(item.date.day.toString()),
            ),
          ),
        ),
      );

      // Should have weekday abbreviations (Mo, Tu, We, Th, Fr, Sa, Su)
      expect(find.text('Mo'), findsOneWidget);
      expect(find.text('Tu'), findsOneWidget);
      expect(find.text('We'), findsOneWidget);
      expect(find.text('Th'), findsOneWidget);
      expect(find.text('Fr'), findsOneWidget);
      expect(find.text('Sa'), findsOneWidget);
      expect(find.text('Su'), findsOneWidget);
    });

    testWidgets('renders all grid items', (tester) async {
      final gridData = VNLCalendarGridData(month: 3, year: 2024);

      await tester.pumpWidget(
        SimpleApp(
          child: VNLCalendarGrid(
            data: gridData,
            itemBuilder: (item) => Container(
              key: ValueKey(item.date),
              alignment: Alignment.center,
              child: Text(item.date.day.toString()),
            ),
          ),
        ),
      );

      // Should have all the date items from the grid (42 items) + 7 weekday headers = 49 total
      final containersInGrid = find.descendant(
        of: find.byType(VNLCalendarGrid),
        matching: find.byType(Container),
      );
      expect(containersInGrid, findsNWidgets(49)); // 7 weekdays + 42 dates
    });

    testWidgets('itemBuilder is called for each grid item', (tester) async {
      final gridData = VNLCalendarGridData(month: 3, year: 2024);
      final renderedItems = <VNLCalendarGridItem>[];

      await tester.pumpWidget(
        SimpleApp(
          child: VNLCalendarGrid(
            data: gridData,
            itemBuilder: (item) {
              renderedItems.add(item);
              return Container(
                alignment: Alignment.center,
                child: Text(item.date.day.toString()),
              );
            },
          ),
        ),
      );

      expect(renderedItems.length, equals(gridData.items.length));
      expect(renderedItems, equals(gridData.items));
    });

    testWidgets('handles different months', (tester) async {
      // Test February (shorter month)
      final febData = VNLCalendarGridData(month: 2, year: 2024);

      await tester.pumpWidget(
        SimpleApp(
          child: VNLCalendarGrid(
            data: febData,
            itemBuilder: (item) => Container(
              alignment: Alignment.center,
              child: Text(item.date.day.toString()),
            ),
          ),
        ),
      );

      expect(find.byType(VNLCalendarGrid), findsOneWidget);
    });

    testWidgets('handles leap year February', (tester) async {
      // Test February in leap year
      final leapFebData =
          VNLCalendarGridData(month: 2, year: 2024); // 2024 is leap year

      await tester.pumpWidget(
        SimpleApp(
          child: VNLCalendarGrid(
            data: leapFebData,
            itemBuilder: (item) => Container(
              alignment: Alignment.center,
              child: Text(item.date.day.toString()),
            ),
          ),
        ),
      );

      expect(find.byType(VNLCalendarGrid), findsOneWidget);
    });

    testWidgets('handles December', (tester) async {
      final decData = VNLCalendarGridData(month: 12, year: 2024);

      await tester.pumpWidget(
        SimpleApp(
          child: VNLCalendarGrid(
            data: decData,
            itemBuilder: (item) => Container(
              alignment: Alignment.center,
              child: Text(item.date.day.toString()),
            ),
          ),
        ),
      );

      expect(find.byType(VNLCalendarGrid), findsOneWidget);
    });

    testWidgets('VNLCalendarGridData creates correct data for March 2024',
        (tester) async {
      final data = VNLCalendarGridData(month: 3, year: 2024);

      expect(data.month, equals(3));
      expect(data.year, equals(2024));
      expect(data.items.length,
          greaterThan(28)); // Should include adjacent month days
      expect(data.items.length % 7, equals(0)); // Should be complete weeks
    });

    testWidgets('VNLCalendarGridData creates correct data for February 2024',
        (tester) async {
      final data = VNLCalendarGridData(month: 2, year: 2024);

      expect(data.month, equals(2));
      expect(data.year, equals(2024));
      expect(data.items.length,
          greaterThan(28)); // Should include adjacent month days
      expect(data.items.length % 7, equals(0)); // Should be complete weeks
    });

    testWidgets('VNLCalendarGridItem has correct properties', (tester) async {
      final date = DateTime(2024, 3, 15);
      final item = VNLCalendarGridItem(date, 5, false, 2);

      expect(item.date, equals(date));
      expect(item.indexInRow, equals(5));
      expect(item.rowIndex, equals(2));
      expect(item.fromAnotherMonth, isFalse);
    });

    testWidgets('VNLCalendarGridItem isToday works correctly', (tester) async {
      final today = DateTime.now();
      final todayItem = VNLCalendarGridItem(today, 0, false, 0);
      final otherDate = DateTime(2024, 1, 1);
      final otherItem = VNLCalendarGridItem(otherDate, 0, false, 0);

      expect(todayItem.isToday, isTrue);
      expect(otherItem.isToday, isFalse);
    });

    testWidgets('VNLCalendarGridItem equality works', (tester) async {
      final date = DateTime(2024, 3, 15);
      final item1 = VNLCalendarGridItem(date, 5, false, 2);
      final item2 = VNLCalendarGridItem(date, 5, false, 2);
      final item3 = VNLCalendarGridItem(date, 6, false, 2);

      expect(item1, equals(item2));
      expect(item1, isNot(equals(item3)));
      expect(item1.hashCode, equals(item2.hashCode));
    });

    testWidgets('VNLCalendarGridData equality works', (tester) async {
      final data1 = VNLCalendarGridData(month: 3, year: 2024);
      final data2 = VNLCalendarGridData(month: 3, year: 2024);
      final data3 = VNLCalendarGridData(month: 4, year: 2024);

      // Same month/year should be equal
      expect(data1, equals(data2));
      // Different month should not be equal
      expect(data1, isNot(equals(data3)));
    });

    testWidgets('grid includes dates from previous month', (tester) async {
      final data = VNLCalendarGridData(month: 3, year: 2024);
      final firstDayOfMonth = DateTime(2024, 3, 1);
      final firstItem = data.items.first;

      // First item should be from February if March 1st is not a Sunday
      if (firstDayOfMonth.weekday != DateTime.sunday) {
        expect(firstItem.fromAnotherMonth, isTrue);
        expect(firstItem.date.month, equals(2)); // February
      }
    });

    testWidgets('grid includes dates from next month', (tester) async {
      final data = VNLCalendarGridData(month: 3, year: 2024);
      final lastItem = data.items.last;

      // Last item should be from April if March doesn't end on Saturday
      final lastDayOfMonth = DateTime(2024, 3, 31);
      if (lastDayOfMonth.weekday != DateTime.saturday) {
        expect(lastItem.fromAnotherMonth, isTrue);
        expect(lastItem.date.month, equals(4)); // April
      }
    });

    testWidgets('current month dates are not fromAnotherMonth', (tester) async {
      final data = VNLCalendarGridData(month: 3, year: 2024);

      final currentMonthItems =
          data.items.where((item) => item.date.month == 3);
      for (final item in currentMonthItems) {
        expect(item.fromAnotherMonth, isFalse);
      }
    });

    testWidgets('grid has correct number of rows', (tester) async {
      final data = VNLCalendarGridData(month: 3, year: 2024);

      await tester.pumpWidget(
        SimpleApp(
          child: VNLCalendarGrid(
            data: data,
            itemBuilder: (item) => Container(
              alignment: Alignment.center,
              child: Text(item.date.day.toString()),
            ),
          ),
        ),
      );

      // Should have weekday header row + date rows
      final expectedRows = (data.items.length / 7).ceil() + 1; // +1 for header
      expect(find.byType(Row), findsNWidgets(expectedRows));
    });

    testWidgets('each row has 7 columns', (tester) async {
      final data = VNLCalendarGridData(month: 3, year: 2024);

      await tester.pumpWidget(
        SimpleApp(
          child: VNLCalendarGrid(
            data: data,
            itemBuilder: (item) => Container(
              alignment: Alignment.center,
              child: Text(item.date.day.toString()),
            ),
          ),
        ),
      );

      // Check that each Row has 7 children (except possibly the header)
      final rows = find.byType(Row);
      for (int i = 0; i < rows.evaluate().length; i++) {
        final row = rows.at(i);
        final rowWidget = tester.widget<Row>(row);
        expect(rowWidget.children.length, equals(7));
      }
    });
  });
}
