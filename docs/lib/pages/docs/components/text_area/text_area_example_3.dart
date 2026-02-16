import 'package:vnl_common_ui/vnl_ui.dart';

// Demonstrates a VNLTextArea that expands both horizontally and vertically.

class TextAreaExample3 extends StatelessWidget {
  const TextAreaExample3({super.key});

  @override
  Widget build(BuildContext context) {
    return const VNLTextArea(
      initialValue: 'Hello, World!',
      // Enable both horizontal and vertical growth based on content.
      expandableWidth: true,
      expandableHeight: true,
      // Larger starting dimensions to make the behavior obvious.
      initialWidth: 500,
      initialHeight: 300,
    );
  }
}
