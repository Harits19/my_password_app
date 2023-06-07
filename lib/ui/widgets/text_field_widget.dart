import 'package:flutter/material.dart';
import 'package:my_password_app/extensions/string_extension.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    this.decoration = const InputDecoration(),
    this.mandatory = false,
    this.readOnly = false,
    this.controller,
    this.maxLines = 1,
    this.validator,
  });

  final InputDecoration decoration;
  final bool mandatory;
  final bool readOnly;
  final TextEditingController? controller;
  final int? maxLines;
  final FormFieldValidator<String?>? validator;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: widget.controller?.text,
      validator: (val) {
        if (widget.mandatory) {
          return val.isNullEmpty ? 'Required' : null;
        }
        return widget.validator?.call(val);
      },
      builder: (field) {
        final ThemeData themeData = Theme.of(context);

        print(themeData.colorScheme.error);
        final errorText = field.errorText;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: TextFormField(
                onChanged: (val) {
                  field.didChange(val);
                },
                decoration: widget.decoration,
                readOnly: widget.readOnly,
                controller: widget.controller,
                maxLines: widget.maxLines,
              ),
            ),
            if (!errorText.isNullEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Text(
                  errorText!,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: themeData.colorScheme.error)
                      .merge(
                        widget.decoration.errorStyle,
                      ),
                ),
              ),
          ],
        );
      },
    );
  }
}
