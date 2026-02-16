import 'package:vnl_common_ui/vnl_ui.dart';

/// Dividers with centered labels.
///
/// [VNLDivider.child] can render text or other widgets inline with the rule.
class DividerExample3 extends StatelessWidget {
  const DividerExample3({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Item 1'),
          VNLDivider(
            child: Text('VNLDivider'),
          ),
          Text('Item 2'),
          VNLDivider(
            child: Text('VNLDivider'),
          ),
          Text('Item 3'),
        ],
      ),
    );
  }
}
