import 'package:vnl_common_ui/shadcn_flutter.dart';
import 'package:vnl_common_ui_genui/src/gen_schema.dart';

/// Shows the live validation error for another field in the same ambient
/// [Form], referenced by [fieldId]. A separate, AI-placed component rather
/// than something a field renders itself — validation display is not an
/// individual field's concern (see [GenFieldDescriptor.validators]).
class GenFormFieldErrorSchema extends GenSchema {
  late final GenField<String> fieldId;

  @override
  void describeFields(GenFieldDescriptor descriptor) {
    fieldId = descriptor.string(
      'fieldId',
      label: 'The id of the field to show the validation error for',
      example: 'email1',
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    // VNLFormErrorBuilder asserts an ambient Form exists, so only reach for
    // it once we know there is one — this widget stays inert otherwise.
    if (Form.maybeOf(context) == null) return const SizedBox.shrink();
    final key = FormKey<Object?>(fieldId[context]);
    return VNLFormErrorBuilder(
      builder: (context, errors, child) {
        final error = errors[key];
        if (error is! VNLInvalidResult) return const SizedBox.shrink();
        return Text(
          error.message,
        ).small(color: Theme.of(context).colorScheme.destructive);
      },
    );
  }
}

const genFormFieldError = GenCatalogItem(
  name: 'FormFieldError',
  label: "Shows another field's current validation error message, by id.",
  schema: GenFormFieldErrorSchema.new,
);
