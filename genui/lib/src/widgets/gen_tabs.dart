import 'package:vnl_common_ui/shadcn_flutter.dart';
import 'package:vnl_common_ui_genui/src/gen_schema.dart';
import 'package:vnl_common_ui_genui/src/widgets/gen_text.dart';

class GenTabsSchema extends GenSchema {
  static const newIndexParam = GenIntParameter(
    'value',
    description: 'The newly selected tab index',
  );

  late final GenField<List<String>> labels;
  late final GenField<List<Widget>> content;
  late final GenField<int> index;
  late final GenField<GenValueActionDispatcher<int>?> onChanged;

  @override
  void describeFields(GenFieldDescriptor descriptor) {
    labels = descriptor.list(
      'labels',
      label: 'Tab labels',
      item: descriptor.string('labelItem', label: 'VNLLabel'),
      example: ['Overview', 'Details'],
    );
    content = descriptor.widgetList(
      'content',
      label: 'Tab content widgets',
      example: [
        TextSchema.new.withExample(
          (s) => s.text.example = 'This is the overview tab.',
        ),
        TextSchema.new.withExample(
          (s) => s.text.example = 'This is the details tab.',
        ),
      ],
    );
    index = descriptor.integer('index', label: 'Selected tab index', example: 0);
    onChanged = descriptor.optionalValueAction<int>(
      'onChanged',
      label: 'Triggered when a different tab is selected',
      parameter: newIndexParam,
      example: const SetValueExample('root.index', {'var': 'value'}),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    final tabLabels = labels[context];
    final tabContent = content[context];
    final count = tabLabels.length < tabContent.length
        ? tabLabels.length
        : tabContent.length;
    if (count == 0) return const SizedBox.shrink();
    final selected = index[context].clamp(0, count - 1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        VNLTabs(
          index: selected,
          onChanged: onChanged[context].toValueCallback(context) ?? (_) {},
          children: [
            for (final label in tabLabels.take(count)) VNLTabItem(child: Text(label)),
          ],
        ),
        IndexedStack(index: selected, children: tabContent.take(count).toList()),
      ],
    );
  }
}

const genTabs = GenCatalogItem(
  name: 'VNLTabs',
  label: 'A tabbed layout that switches between several panes of content.',
  schema: GenTabsSchema.new,
);
