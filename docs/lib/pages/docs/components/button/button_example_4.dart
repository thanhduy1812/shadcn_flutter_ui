import 'package:vnl_common_ui/vnl_ui.dart';

/// Ghost button.
///
/// Very subtle styling for least-emphasis or inline actions.
class ButtonExample4 extends StatelessWidget {
  const ButtonExample4({super.key});

  @override
  Widget build(BuildContext context) {
    return VNLGhostButton(
      onPressed: () {},
      child: const Text('Ghost'),
    );
  }
}
