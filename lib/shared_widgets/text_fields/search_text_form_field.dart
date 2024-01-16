import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../res/style/app_colors.dart';

import 'abstract/main_text_form_field.dart';

class SearchTextFormField extends MainTextFormField {
  SearchTextFormField(
      {Key? key,
      required final FocusNode currentFocusNode,
      required final TextEditingController currentController,
      final EdgeInsetsGeometry? margin,
      final String? hint = 'search_hint',
      bool enabled = true,
      final TextStyle? style,
      final Color? borderColor,
      final void Function(String)? onChanged})
      : super(
          key: key,
          currentController: currentController,
          currentFocusNode: currentFocusNode,
          hintText: hint!.tr(),
          keyboardType: TextInputType.emailAddress,
          margin: margin,
          enabled: enabled,
          validator: null,
          fillColor: Colors.white,
          borderColor: borderColor,
          style: style,
          hintColor: AppColors.PRIMARY_COLOR_DARK,
          prefixIcon:
              const Icon(Icons.search, color: AppColors.PRIMARY_COLOR_DARK),
          onChanged: onChanged,
          cursorColor: AppColors.ACCENT_COLOR,
        );
}
