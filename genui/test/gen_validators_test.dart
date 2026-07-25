import 'package:flutter_test/flutter_test.dart';
import 'package:genui/genui.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';
import 'package:vnl_common_ui_genui/vnl_genui.dart';

void main() {
  testWidgets(
    'validators<T> composes selected kinds via AND and ignores an unknown kind',
    (tester) async {
      final catalog = GenCatalog.asCatalog();
      final controller = SurfaceController(catalogs: [catalog]);
      controller.handleMessage(
        UpdateComponents(
          surfaceId: 'main',
          components: [
            Component(
              id: 'root',
              type: 'VNLTextField',
              properties: const {
                'value': '',
                'value_validators': [
                  {'kind': 'notEmpty'},
                  {'kind': 'length', 'min': 3},
                  {'kind': 'bogus'},
                ],
              },
            ),
          ],
        ),
      );
      controller.handleMessage(
        CreateSurface(surfaceId: 'main', catalogId: catalog.catalogId!),
      );

      late VNLFormController formController;
      await tester.pumpWidget(
        ShadcnApp(
          home: Form(
            child: Builder(
              builder: (context) {
                formController = Form.of(context);
                return Surface(surfaceContext: controller.contextFor('main'));
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      Future<void> submit() async {
        final ctx = tester.element(find.byType(VNLTextField));
        final result = ctx.submitForm();
        if (result is Future) await result;
        await tester.pumpAndSettle();
      }

      // Empty: fails notEmpty. The unknown 'bogus' kind must not crash.
      await submit();
      expect(formController.errors.values.whereType<VNLInvalidResult>(), isNotEmpty);

      // Too short: fails length (min 3).
      await tester.enterText(find.byType(VNLTextField), 'ab');
      await submit();
      expect(formController.errors.values.whereType<VNLInvalidResult>(), isNotEmpty);

      // Passes both.
      await tester.enterText(find.byType(VNLTextField), 'abc');
      await submit();
      expect(formController.errors.values.whereType<VNLInvalidResult>(), isEmpty);

      controller.dispose();
    },
  );
}
