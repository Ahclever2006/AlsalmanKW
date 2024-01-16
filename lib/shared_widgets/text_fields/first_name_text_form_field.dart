import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/utils/validator.dart';
import 'abstract/main_text_form_field.dart';

class FirstNameTextFormField extends MainTextFormField {
  FirstNameTextFormField({
    Key? key,
    required final FocusNode currentFocusNode,
    required final FocusNode nextFocusNode,
    required final TextEditingController currentController,
    final EdgeInsetsGeometry? margin,
    final bool enabled = true,
    final int? maxLength,
  }) : super(
          key: key,
          currentController: currentController,
          currentFocusNode: currentFocusNode,
          nextFocusNode: nextFocusNode,
          validator: Validator().validateUserName,
          hintText: 'first_name'.tr(),
          keyboardType: TextInputType.name,
          margin: margin,maxLength: maxLength,
          textCapitalization: TextCapitalization.words,
          enabled: enabled,
        );
}
