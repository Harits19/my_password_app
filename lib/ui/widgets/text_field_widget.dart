import 'package:flutter/material.dart';
import 'package:my_password_app/extensions/string_extension.dart';

class TextFieldWidget extends TextFormField {
  TextFieldWidget({
    super.key,
    super.controller,
    super.initialValue,
    super.focusNode,
    super.decoration,
    super.keyboardType,
    super.textCapitalization,
    super.textInputAction,
    super.style,
    super.strutStyle,
    super.textDirection,
    super.textAlign,
    super.textAlignVertical,
    super.autofocus,
    super.readOnly,
    @Deprecated(
      'Use `contextMenuBuilder` instead. '
      'This feature was deprecated after v3.3.0-0.5.pre.',
    )
    super.toolbarOptions,
    super.showCursor,
    super.obscuringCharacter,
    super.obscureText,
    super.autocorrect,
    super.smartDashesType,
    super.smartQuotesType,
    super.enableSuggestions,
    super.maxLengthEnforcement,
    super.maxLines,
    super.minLines,
    super.expands,
    super.maxLength,
    super.onChanged,
    super.onTap,
    super.onTapOutside,
    super.onEditingComplete,
    super.onFieldSubmitted,
    super.onSaved,
    FormFieldValidator<String>? validator,
    super.inputFormatters,
    super.enabled,
    super.cursorWidth,
    super.cursorHeight,
    super.cursorRadius,
    super.cursorColor,
    super.keyboardAppearance,
    super.scrollPadding,
    super.enableInteractiveSelection,
    super.selectionControls,
    super.buildCounter,
    super.scrollPhysics,
    super.autofillHints,
    super.autovalidateMode,
    super.scrollController,
    super.restorationId,
    super.enableIMEPersonalizedLearning,
    super.mouseCursor,
    super.contextMenuBuilder,
    super.spellCheckConfiguration,
    super.magnifierConfiguration,
    bool mandatory = false,
  }) : super(
          validator: (val) {
            if (mandatory) {
              return val.isNullEmpty ? 'Required' : null;
            }
            return validator == null ? null : validator(val);
          },
        );
}
