import 'package:vnl_common_ui/vnl_ui.dart';

class ButtonExample10 extends StatelessWidget {
  const ButtonExample10({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      children: [
        PrimaryButton(
          size: VNLButtonSize.xSmall,
          onPressed: () {},
          child: const Text('Extra Small'),
        ),
        PrimaryButton(
          onPressed: () {},
          size: VNLButtonSize.small,
          child: const Text('Small'),
        ),
        PrimaryButton(
          size: VNLButtonSize.normal,
          onPressed: () {},
          child: const Text('Normal'),
        ),
        PrimaryButton(
          size: VNLButtonSize.large,
          onPressed: () {},
          child: const Text('Large'),
        ),
        PrimaryButton(
          size: VNLButtonSize.xLarge,
          onPressed: () {},
          child: const Text('Extra Large'),
        ),
      ],
    );
  }
}
