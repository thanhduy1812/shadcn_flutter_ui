import 'package:vnl_common_ui/vnl_ui.dart';

// Demonstrates a VNLTextArea that expands vertically with its content.

class TextAreaExample1 extends StatelessWidget {
  const TextAreaExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return const VNLTextArea(
      initialValue: 'Hello, World!',
      // Let the text area grow vertically with content up to constraints.
      expandableHeight: true,
      // Start with a taller initial height to show multiple lines.
      initialHeight: 300,
    );
  }
}
