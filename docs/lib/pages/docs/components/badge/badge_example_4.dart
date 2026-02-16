import 'package:vnl_common_ui/vnl_ui.dart';

/// Destructive badge style.
///
/// Use `VNLDestructiveBadge` to call attention to critical or dangerous states.
class BadgeExample4 extends StatelessWidget {
  const BadgeExample4({super.key});

  @override
  Widget build(BuildContext context) {
    return const VNLDestructiveBadge(
      child: Text('Destructive'),
    );
  }
}
