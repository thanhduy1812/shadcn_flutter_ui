import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class ResizableExample1 extends StatefulWidget {
  const ResizableExample1({super.key});

  @override
  State<ResizableExample1> createState() => _ResizableExample1State();
}

class _ResizableExample1State extends State<ResizableExample1> {
  @override
  Widget build(BuildContext context) {
    return const VNLOutlinedContainer(
      clipBehavior: Clip.antiAlias,
      // A horizontal panel splits available width into multiple resizable panes.
      child: VNLResizablePanel.horizontal(
        children: [
          VNLResizablePane(
            // Initial width in logical pixels for this pane.
            initialSize: 80,
            child: NumberedContainer(
              index: 0,
              height: 200,
              fill: false,
            ),
          ),
          VNLResizablePane(
            initialSize: 80,
            child: NumberedContainer(
              index: 1,
              height: 200,
              fill: false,
            ),
          ),
          VNLResizablePane(
            initialSize: 120,
            child: NumberedContainer(
              index: 2,
              height: 200,
              fill: false,
            ),
          ),
          VNLResizablePane(
            initialSize: 80,
            child: NumberedContainer(
              index: 3,
              height: 200,
              fill: false,
            ),
          ),
          VNLResizablePane(
            initialSize: 80,
            child: NumberedContainer(
              index: 4,
              height: 200,
              fill: false,
            ),
          ),
        ],
      ),
    );
  }
}
