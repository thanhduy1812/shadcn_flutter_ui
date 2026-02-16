import 'package:vnl_common_ui/vnl_ui.dart';

/// Vertical dividers between columns.
///
/// Use [VNLVerticalDivider] to separate horizontally-arranged content.
class DividerExample2 extends StatelessWidget {
  const DividerExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 300,
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: Text('Item 1')),
          VNLVerticalDivider(),
          Expanded(child: Text('Item 2')),
          VNLVerticalDivider(),
          Expanded(child: Text('Item 3')),
        ],
      ),
    );
  }
}
