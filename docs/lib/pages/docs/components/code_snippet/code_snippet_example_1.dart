import 'package:vnl_common_ui/vnl_ui.dart';

/// VNLCodeSnippet for showing read-only command or code blocks.
///
/// `mode` controls syntax highlighting; here we show a shell command.
class CodeSnippetExample1 extends StatelessWidget {
  const CodeSnippetExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return const VNLCodeSnippet(
      code: Text('flutter pub get'),
    );
  }
}
