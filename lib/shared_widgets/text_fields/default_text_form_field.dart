import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/utils/validator.dart';
import 'abstract/main_text_form_field.dart';

class DefaultTextFormField extends MainTextFormField {
  DefaultTextFormField({
    Key? key,
    required final FocusNode currentFocusNode,
    final FocusNode? nextFocusNode,
    required final TextEditingController currentController,
    required final String hint,
    final TextInputType keyboardType = TextInputType.text,
    final EdgeInsetsGeometry? margin,
    final EdgeInsetsGeometry? contentPadding,
    final VoidCallback? onTap,
    final bool enabled = true,
    final bool isRequired = false,
    final bool expanded = false,
    final List<TextInputFormatter>? inputFormatter,
    final int? maxLines,
    final bool? obscureText,
    final Widget? suffixIcon,
    final String? Function(String?)? validator,
    final ValueChanged<String>? onChanged,
  }) : super(
          key: key,
          currentController: currentController,
          currentFocusNode: currentFocusNode,
          nextFocusNode: nextFocusNode,
          validator:
              validator ?? (isRequired ? Validator().validateEmptyField : null),
          hintText: hint + (isRequired ? '*' : ''),
          keyboardType: keyboardType,
          margin: margin,
          onTap: onTap,
          textCapitalization: TextCapitalization.words,
          enabled: enabled,
          expanded: expanded,
          maxLines: maxLines,
          obscureText: obscureText,
          suffixIcon: suffixIcon,
          contentPadding: contentPadding,
          onChanged: onChanged,
          inputFormatters: inputFormatter,
        );
}
