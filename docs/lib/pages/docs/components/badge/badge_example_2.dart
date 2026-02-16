import 'package:vnl_common_ui/vnl_ui.dart';

/// Secondary badge style.
///
/// Use `VNLSecondaryBadge` for a lighter emphasis compared to primary.
class BadgeExample2 extends StatelessWidget {
  const BadgeExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return const VNLSecondaryBadge(
      child: Text('Secondary'),
    );
  }
}
