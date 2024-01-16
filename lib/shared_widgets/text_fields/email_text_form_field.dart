import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/utils/validator.dart';
import 'abstract/main_text_form_field.dart';

class EmailTextFormField extends MainTextFormField {
  EmailTextFormField({
    Key? key,
    required final FocusNode currentFocusNode,
    final FocusNode? nextFocusNode,
    required final TextEditingController currentController,
    final EdgeInsetsGeometry? margin,
    bool enabled = true,
  }) : super(
            key: key,
            currentController: currentController,
            currentFocusNode: currentFocusNode,
            nextFocusNode: nextFocusNode,
            validator: Validator().validateEmail,
            hintText: 'email_address'.tr(),
            keyboardType: TextInputType.emailAddress,
            margin: margin,
            enabled: enabled,
            inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r" "))]);
}
