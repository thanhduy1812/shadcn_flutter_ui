import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vnl_common_ui_genui/vnl_genui.dart';

void main() {
  test('GenCatalog.asCatalog assembles all 8 widgets plus basics', () {
    final catalog = GenCatalog.asCatalog();
    final names = catalog.items.map((item) => item.name).toSet();
    for (final expected in [
      'VNLTextField',
      'CheckBox',
      'VNLSwitch',
      'Select',
      'VNLButton',
      'VNLCard',
      'VNLAlert',
      'Badge',
    ]) {
      expect(names, contains(expected));
    }
    // Merged with genui's own non-asset basics, e.g. Text/Column/Row, so
    // widget/optionalWidget fields (VNLCard.child, VNLButton.child, ...) have
    // something to reference in example data.
    expect(names, contains('Text'));
  });

  test('a system function is exposed as both a ClientFunction and via the registry', () {
    final function = _EchoFunction();
    final catalog = GenCatalog.asCatalog(systemFunctions: [function]);
    expect(catalog.functions.any((f) => f.name == 'echo'), isTrue);
  });
}

class _EchoFunction extends GenSystemFunction {
  @override
  String get name => 'echo';
  @override
  String get description => 'Returns its input.';
  @override
  void describeFields(GenDataFieldDescriptor descriptor) {}
  @override
  Future<Object?> invoke([BuildContext? context]) async => 'echo';
}
