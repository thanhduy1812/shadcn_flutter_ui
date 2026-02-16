import 'package:vnl_common_ui/vnl_ui.dart';

class InputOTPExample1 extends StatefulWidget {
  const InputOTPExample1({super.key});

  @override
  State<InputOTPExample1> createState() => _InputOTPExample1State();
}

class _InputOTPExample1State extends State<InputOTPExample1> {
  String value = '';
  String? submittedValue;
  @override
  Widget build(BuildContext context) {
    // VNLBasic OTP input with onChanged and onSubmitted callbacks.
    // The example groups 3 digits, a visual separator, then 3 more digits.
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        VNLInputOTP(
          onChanged: (value) {
            setState(() {
              this.value = value.otpToString();
            });
          },
          onSubmitted: (value) {
            setState(() {
              submittedValue = value.otpToString();
            });
          },
          children: [
            // Each character cell allows digits. The separator is a visual divider only.
            VNLInputOTPChild.character(allowDigit: true),
            VNLInputOTPChild.character(allowDigit: true),
            VNLInputOTPChild.character(allowDigit: true),
            VNLInputOTPChild.separator,
            VNLInputOTPChild.character(allowDigit: true),
            VNLInputOTPChild.character(allowDigit: true),
            VNLInputOTPChild.character(allowDigit: true),
          ],
        ),
        gap(16),
        Text('Value: $value'),
        Text('Submitted Value: $submittedValue'),
      ],
    );
  }
}
