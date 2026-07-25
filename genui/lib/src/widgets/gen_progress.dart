import 'package:vnl_common_ui/shadcn_flutter.dart';
import 'package:vnl_common_ui_genui/src/gen_schema.dart';

class GenProgressSchema extends GenSchema {
  late final GenField<double> value;
  late final GenField<double> min;
  late final GenField<double> max;

  @override
  void describeFields(GenFieldDescriptor descriptor) {
    value = descriptor.decimal(
      'value',
      label: 'Current progress',
      example: 50.0,
    );
    min = descriptor.decimal('min', label: 'Minimum value', example: 0.0);
    max = descriptor.decimal('max', label: 'Maximum value', example: 100.0);
  }

  @override
  Widget buildWidget(BuildContext context) {
    return VNLProgress(
      progress: value[context],
      min: min[context],
      max: max[context],
    );
  }
}

const genProgress = GenCatalogItem(
  name: 'VNLProgress',
  label: 'A horizontal bar showing progress toward a value between a minimum and maximum.',
  schema: GenProgressSchema.new,
);
