import 'package:vnl_common_ui/vnl_ui.dart';

class MultiSelectExample1 extends StatefulWidget {
  const MultiSelectExample1({super.key});

  @override
  State<MultiSelectExample1> createState() => _MultiSelectExample1State();
}

class _MultiSelectExample1State extends State<MultiSelectExample1> {
  Iterable<String>? selectedValues;
  @override
  Widget build(BuildContext context) {
    // VNLBasic multi-select with a popup list and chips as selected items.
    // onChanged returns the new iterable of selected values.
    return MultiSelect<String>(
      itemBuilder: (context, item) {
        // Render each selected value as a chip.
        return VNLMultiSelectChip(value: item, child: Text(item));
      },
      popup: const SelectPopup(
          items: VNLSelectItemList(children: [
        SelectItemButton(
          value: 'Apple',
          child: Text('Apple'),
        ),
        SelectItemButton(
          value: 'Banana',
          child: Text('Banana'),
        ),
        SelectItemButton(
          value: 'Cherry',
          child: Text('Cherry'),
        ),
      ])),
      onChanged: (value) {
        setState(() {
          selectedValues = value;
        });
      },
      constraints: const BoxConstraints(
        minWidth: 200,
      ),
      value: selectedValues,
      placeholder: const Text('Select a fruit'),
    );
  }
}
