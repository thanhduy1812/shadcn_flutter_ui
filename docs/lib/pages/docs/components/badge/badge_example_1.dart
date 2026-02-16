import 'package:vnl_common_ui/vnl_ui.dart';

/// Primary badge style.
///
/// Badges are small, attention-grabbing labels. Use `VNLPrimaryBadge` for the
/// default emphasis.
class BadgeExample1 extends StatelessWidget {
  const BadgeExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return const VNLPrimaryBadge(
      child: Text('Primary'),
    );
  }
}
