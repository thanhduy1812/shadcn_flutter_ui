import 'package:vnl_common_ui/vnl_ui.dart';

// Demonstrates toast overlays in different screen locations with a custom
// content builder and programmatic close via the overlay handle.

class ToastExample1 extends StatefulWidget {
  const ToastExample1({super.key});

  @override
  State<ToastExample1> createState() => _ToastExample1State();
}

class _ToastExample1State extends State<ToastExample1> {
  // Builder for the toast content; receives an overlay handle so we can close it.
  Widget buildToast(BuildContext context, VNLToastOverlay overlay) {
    return VNLSurfaceCard(
      child: VNLBasic(
        title: const Text('Event has been created'),
        subtitle: const Text('Sunday, July 07, 2024 at 12:00 PM'),
        trailing: PrimaryButton(
            size: VNLButtonSize.small,
            onPressed: () {
              // Close the toast programmatically when clicking Undo.
              overlay.close();
            },
            child: const Text('Undo')),
        trailingAlignment: Alignment.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        PrimaryButton(
          onPressed: () {
            showToast(
              context: context,
              builder: buildToast,
              // Position bottom-left.
              location: ToastLocation.bottomLeft,
            );
          },
          child: const Text('Show Bottom Left Toast'),
        ),
        PrimaryButton(
          onPressed: () {
            showToast(
              context: context,
              builder: buildToast,
              // Position bottom-right.
              location: ToastLocation.bottomRight,
            );
          },
          child: const Text('Show Bottom Right Toast'),
        ),
        PrimaryButton(
          onPressed: () {
            showToast(
              context: context,
              builder: buildToast,
              // Position top-left.
              location: ToastLocation.topLeft,
            );
          },
          child: const Text('Show Top Left Toast'),
        ),
        PrimaryButton(
          onPressed: () {
            showToast(
              context: context,
              builder: buildToast,
              // Position top-right.
              location: ToastLocation.topRight,
            );
          },
          child: const Text('Show Top Right Toast'),
        ),
        // bottom center
        PrimaryButton(
          onPressed: () {
            showToast(
              context: context,
              builder: buildToast,
              location: ToastLocation.bottomCenter,
            );
          },
          child: const Text('Show Bottom Center Toast'),
        ),
        // top center
        PrimaryButton(
          onPressed: () {
            showToast(
              context: context,
              builder: buildToast,
              location: ToastLocation.topCenter,
            );
          },
          child: const Text('Show Top Center Toast'),
        ),
      ],
    );
  }
}
