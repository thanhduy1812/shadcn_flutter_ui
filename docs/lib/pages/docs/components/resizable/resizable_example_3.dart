import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class ResizableExample3 extends StatefulWidget {
  const ResizableExample3({super.key});

  @override
  State<ResizableExample3> createState() => _ResizableExample3State();
}

class _ResizableExample3State extends State<ResizableExample3> {
  @override
  Widget build(BuildContext context) {
    return VNLOutlinedContainer(
      clipBehavior: Clip.antiAlias,
      child: VNLResizablePanel.horizontal(
        // Provide a custom dragger appearance/behavior for the splitters.
        draggerBuilder: (context) {
          return const VNLHorizontalResizableDragger();
        },
        children: const [
          VNLResizablePane(
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
