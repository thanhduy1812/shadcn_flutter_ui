import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class ResizableExample2 extends StatefulWidget {
  const ResizableExample2({super.key});

  @override
  State<ResizableExample2> createState() => _ResizableExample2State();
}

class _ResizableExample2State extends State<ResizableExample2> {
  @override
  Widget build(BuildContext context) {
    return const VNLOutlinedContainer(
      clipBehavior: Clip.antiAlias,
      // A vertical panel splits available height into multiple resizable rows (panes).
      child: VNLResizablePanel.vertical(
        children: [
          VNLResizablePane(
            // Initial height in logical pixels for this row.
            initialSize: 80,
            child: NumberedContainer(
              index: 0,
              width: 200,
              fill: false,
            ),
          ),
          VNLResizablePane(
            initialSize: 120,
            child: NumberedContainer(
              index: 1,
              width: 200,
              fill: false,
            ),
          ),
          VNLResizablePane(
            initialSize: 80,
            child: NumberedContainer(
              index: 2,
              width: 200,
              fill: false,
            ),
          ),
        ],
      ),
    );
  }
}
