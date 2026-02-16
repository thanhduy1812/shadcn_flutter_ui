import 'package:vnl_common_ui/vnl_ui.dart';

// Demonstrates a VNLTracker strip with varying levels (fine/warning/critical)
// and per-cell tooltips, similar to a heatmap timeline.

class TrackerExample1 extends StatefulWidget {
  const TrackerExample1({super.key});

  @override
  State<TrackerExample1> createState() => _TrackerExample1State();
}

class _TrackerExample1State extends State<TrackerExample1> {
  @override
  Widget build(BuildContext context) {
    // Build a simple sequence of tracker cells with different severity levels.
    List<VNLTrackerData> data = [];
    for (int i = 0; i < 80; i++) {
      data.add(const VNLTrackerData(
        tooltip: Text('VNLTracker Fine'),
        level: VNLTrackerLevel.fine,
      ));
    }
    // Mark some indices as warnings.
    data[40] = data[35] = const VNLTrackerData(
      tooltip: Text('VNLTracker Warning'),
      level: VNLTrackerLevel.warning,
    );
    // And a few as critical.
    data[60] = data[68] = data[72] = const VNLTrackerData(
      tooltip: Text('VNLTracker Critical'),
      level: VNLTrackerLevel.critical,
    );
    // Unknown levels to show a broader legend.
    for (int i = 8; i < 16; i++) {
      data[i] = const VNLTrackerData(
        tooltip: Text('VNLTracker Unknown'),
        level: VNLTrackerLevel.unknown,
      );
    }
    // VNLTracker renders a compact heatmap-like strip with tooltips per cell.
    return VNLTracker(data: data);
  }
}
