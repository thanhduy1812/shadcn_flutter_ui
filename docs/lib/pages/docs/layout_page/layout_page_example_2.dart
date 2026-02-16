import 'package:vnl_common_ui/vnl_ui.dart';

class LayoutPageExample2 extends StatelessWidget {
  const LayoutPageExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: VNLColors.red,
      child: Container(
        margin: const EdgeInsets.only(top: 24, bottom: 12, left: 16, right: 16),
        color: VNLColors.green,
        child: Container(
          color: VNLColors.blue,
          height: 20,
          margin: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}
