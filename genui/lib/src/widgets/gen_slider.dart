import 'package:vnl_common_ui/shadcn_flutter.dart';
import 'package:vnl_common_ui_genui/src/gen_schema.dart';

class GenSliderSchema extends GenSchema {
  static final newValueParam = const GenDecimalParameter(
    'value',
    description: 'The current value while dragging',
  ).map<VNLSliderValue>((v) => v.value);
  static final finalValueParam = const GenDecimalParameter(
    'value',
    description: 'The value once dragging ends',
  ).map<VNLSliderValue>((v) => v.value);

  late final GenField<double> value;
  late final GenField<double> min;
  late final GenField<double> max;
  late final GenField<GenValueActionDispatcher<VNLSliderValue>?> onChanged;
  late final GenField<GenValueActionDispatcher<VNLSliderValue>?> onChangeEnd;

  @override
  void describeFields(GenFieldDescriptor descriptor) {
    value = descriptor.decimal('value', label: 'Current value', example: 0.5);
    min = descriptor.decimal('min', label: 'Minimum value', example: 0.0);
    max = descriptor.decimal('max', label: 'Maximum value', example: 1.0);
    onChanged = descriptor.optionalValueAction<VNLSliderValue>(
      'onChanged',
      label: 'Triggered continuously while dragging',
      parameter: newValueParam,
      example: const SetValueExample('root.value', {'var': 'value'}),
    );
    onChangeEnd = descriptor.optionalValueAction<VNLSliderValue>(
      'onChangeEnd',
      label: 'Triggered once the user finishes dragging (acts as submission)',
      parameter: finalValueParam,
      example: const EventExample('changed', context: {'value': {'var': 'value'}}),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    final field = VNLSlider(
      value: VNLSliderValue.single(value[context]),
      min: min[context],
      max: max[context],
      onChanged: onChanged[context].toValueCallback(context),
      onChangeEnd: onChangeEnd[context].toValueCallback(context),
    );
    return wrapFormEntry<VNLSliderValue>(
      context: context,
      validator: null,
      field: field,
    );
  }
}

const genSlider = GenCatalogItem(
  name: 'VNLSlider',
  label: 'A draggable slider for picking a numeric value within a min/max range.',
  schema: GenSliderSchema.new,
);
