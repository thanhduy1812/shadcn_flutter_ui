import 'package:vnl_common_ui/shadcn_flutter.dart';
import 'package:vnl_common_ui_genui/src/gen_schema.dart';
import 'package:vnl_common_ui_genui/src/widgets/gen_text.dart';

class GenCardSchema extends GenSchema {
  late final GenField<Widget> child;

  @override
  void describeFields(GenFieldDescriptor descriptor) {
    child = descriptor.widget(
      'child',
      label: 'VNLCard body',
      example: TextSchema.new.withExample((s) => s.text.example = 'VNLCard body'),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return VNLCard(child: child[context]);
  }
}

const genCard = GenCatalogItem(
  name: 'VNLCard',
  label: 'A bordered container that visually groups its child content.',
  schema: GenCardSchema.new,
);
