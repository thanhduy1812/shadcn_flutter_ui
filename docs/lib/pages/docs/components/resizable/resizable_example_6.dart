import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class ResizableExample6 extends StatefulWidget {
  const ResizableExample6({super.key});

  @override
  State<ResizableExample6> createState() => _ResizableExample6State();
}

class _ResizableExample6State extends State<ResizableExample6> {
  @override
  Widget build(BuildContext context) {
    return const VNLOutlinedContainer(
      clipBehavior: Clip.antiAlias,
      // Demonstrates nesting panels: horizontal root with vertical and horizontal children.
      child: VNLResizablePanel.horizontal(
        children: [
          VNLResizablePane(
            initialSize: 100,
            minSize: 40,
            child: NumberedContainer(
              index: 0,
              height: 200,
              fill: false,
            ),
          ),
          VNLResizablePane(
            minSize: 100,
            initialSize: 300,
            // Middle pane is its own vertical resizable group.
            child: VNLResizablePanel.vertical(
              children: [
                VNLResizablePane(
                  initialSize: 80,
                  minSize: 40,
                  child: NumberedContainer(
                    index: 1,
                    fill: false,
                  ),
                ),
                VNLResizablePane(
                  minSize: 40,
                  initialSize: 120,
                  // This pane contains a horizontal panel using flexible panes below.
                  child: VNLResizablePanel.horizontal(
                    children: [
                      // Flex panes share remaining space proportionally.
                      VNLResizablePane.flex(
                        child: NumberedContainer(
                          index: 2,
                          fill: false,
                        ),
                      ),
                      VNLResizablePane.flex(
                        child: NumberedContainer(
                          index: 3,
                          fill: false,
                        ),
                      ),
                      VNLResizablePane.flex(
                        child: NumberedContainer(
                          index: 4,
                          fill: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          VNLResizablePane(
            initialSize: 100,
            minSize: 40,
            child: NumberedContainer(
              index: 5,
              height: 200,
              fill: false,
            ),
          ),
        ],
      ),
    );
  }
}
