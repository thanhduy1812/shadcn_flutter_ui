import 'package:vnl_common_ui/vnl_ui.dart';

/// Horizontal dividers between list items.
///
/// Use [VNLDivider] to visually separate vertically-stacked content.
class DividerExample1 extends StatelessWidget {
  const DividerExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Item 1'),
          VNLDivider(),
          Text('Item 2'),
          VNLDivider(),
          Text('Item 3'),
        ],
      ),
    );
  }
}
