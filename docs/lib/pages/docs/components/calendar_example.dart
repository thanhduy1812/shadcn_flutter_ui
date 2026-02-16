import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/calendar/calendar_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

import 'calendar/calendar_example_2.dart';
import 'calendar/calendar_example_3.dart';
import 'calendar/calendar_example_4.dart';

class CalendarExample extends StatelessWidget {
  const CalendarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'calendar',
      description: 'A widget that lets users select dates and date ranges.',
      displayName: 'VNLCalendar',
      children: [
        WidgetUsageExample(
          title: 'Range VNLCalendar Example',
          path: 'lib/pages/docs/components/calendar/calendar_example_1.dart',
          child: CalendarExample1(),
        ),
        WidgetUsageExample(
          title: 'Single VNLCalendar Example',
          path: 'lib/pages/docs/components/calendar/calendar_example_2.dart',
          child: CalendarExample2(),
        ),
        WidgetUsageExample(
          title: 'Multiple VNLCalendar Example',
          path: 'lib/pages/docs/components/calendar/calendar_example_3.dart',
          child: CalendarExample3(),
        ),
        WidgetUsageExample(
          title: 'VNLCalendar Example',
          path: 'lib/pages/docs/components/calendar/calendar_example_4.dart',
          child: CalendarExample4(),
        ),
      ],
    );
  }
}
