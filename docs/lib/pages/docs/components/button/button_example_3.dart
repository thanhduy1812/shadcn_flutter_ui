import 'package:vnl_common_ui/vnl_ui.dart';

/// Outline button.
///
/// Uses an outlined border for a minimal visual weight.
class ButtonExample3 extends StatelessWidget {
  const ButtonExample3({super.key});

  @override
  Widget build(BuildContext context) {
    return VNLOutlineButton(
      onPressed: () {},
      child: const Text('Outlined'),
    );
  }
}
