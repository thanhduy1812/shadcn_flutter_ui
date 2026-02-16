import 'package:flutter/services.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

/// Context menu with shortcuts, submenu, checkboxes, and radio group.
///
/// Right-click (or long-press) the dashed area to open the menu. This
/// demonstrates:
/// - [VNLMenuButton] items with keyboard [VNLMenuShortcut]s.
/// - Nested submenu via [VNLMenuButton.subMenu].
/// - [VNLMenuCheckbox] with `autoClose: false` to keep menu open while toggling.
/// - [MenuRadioGroup] for mutually exclusive choices.
class ContextMenuExample1 extends StatefulWidget {
  const ContextMenuExample1({super.key});

  @override
  State<ContextMenuExample1> createState() => _ContextMenuExample1State();
}

class _ContextMenuExample1State extends State<ContextMenuExample1> {
  int people = 0;
  bool showBookmarksBar = false;
  bool showFullUrls = true;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return VNLContextMenu(
        items: [
          // Simple command with Ctrl+[ shortcut.
          const VNLMenuButton(
            trailing: VNLMenuShortcut(
              activator: SingleActivator(
                LogicalKeyboardKey.bracketLeft,
                control: true,
              ),
            ),
            child: Text('Back'),
          ),
          // Disabled command example with Ctrl+] shortcut.
          const VNLMenuButton(
            trailing: VNLMenuShortcut(
              activator: SingleActivator(
                LogicalKeyboardKey.bracketRight,
                control: true,
              ),
            ),
            enabled: false,
            child: Text('Forward'),
          ),
          // Enabled command with Ctrl+R shortcut.
          const VNLMenuButton(
            trailing: VNLMenuShortcut(
              activator: SingleActivator(
                LogicalKeyboardKey.keyR,
                control: true,
              ),
            ),
            child: Text('Reload'),
          ),
          // Submenu with additional tools and a divider.
          const VNLMenuButton(
            subMenu: [
              VNLMenuButton(
                trailing: VNLMenuShortcut(
                  activator: SingleActivator(
                    LogicalKeyboardKey.keyS,
                    control: true,
                  ),
                ),
                child: Text('Save Page As...'),
              ),
              VNLMenuButton(
                child: Text('Create Shortcut...'),
              ),
              VNLMenuButton(
                child: Text('Name VNLWindow...'),
              ),
              VNLMenuDivider(),
              VNLMenuButton(
                child: Text('Developer Tools'),
              ),
            ],
            child: Text('More Tools'),
          ),
          const VNLMenuDivider(),
          // VNLCheckbox item; keep menu open while toggling for quick changes.
          VNLMenuCheckbox(
            value: showBookmarksBar,
            onChanged: (context, value) {
              setState(() {
                showBookmarksBar = value;
              });
            },
            autoClose: false,
            trailing: const VNLMenuShortcut(
              activator: SingleActivator(
                LogicalKeyboardKey.keyB,
                control: true,
                shift: true,
              ),
            ),
            child: const Text('Show Bookmarks Bar'),
          ),
          VNLMenuCheckbox(
            value: showFullUrls,
            onChanged: (context, value) {
              setState(() {
                showFullUrls = value;
              });
            },
            autoClose: false,
            child: const Text('Show Full URLs'),
          ),
          const VNLMenuDivider(),
          const VNLMenuLabel(child: Text('People')),
          const VNLMenuDivider(),
          // VNLRadio group; only one person can be selected at a time.
          MenuRadioGroup(
            value: people,
            onChanged: (context, value) {
              setState(() {
                people = value;
              });
            },
            children: const [
              MenuRadio(
                value: 0,
                autoClose: false,
                child: Text('Pedro Duarte'),
              ),
              MenuRadio(
                value: 1,
                autoClose: false,
                child: Text('Colm Tuite'),
              ),
            ],
          ),
        ],
        child: VNLDashedContainer(
          // Right-click target with a dashed border and rounded corners.
          borderRadius: BorderRadius.circular(theme.radiusMd),
          strokeWidth: 2,
          gap: 2,
          child: const Text('Right click here').center(),
        ).constrained(
          maxWidth: 300,
          maxHeight: 200,
        ));
  }
}
