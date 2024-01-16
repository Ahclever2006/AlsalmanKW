import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/utils/validator.dart';
import 'default_text_form_field.dart';

class ConfirmPasswordTextFormField extends StatefulWidget {
  const ConfirmPasswordTextFormField({
    Key? key,
    required this.currentFocusNode,
    this.nextFocusNode,
    required this.currentController,
    required this.passwordController,
    this.margin,
    this.hint,
    this.validator,
  }) : super(key: key);

  final FocusNode currentFocusNode;
  final FocusNode? nextFocusNode;
  final TextEditingController currentController;
  final TextEditingController passwordController;
  final EdgeInsetsGeometry? margin;
  final String? hint;
  final String? Function(String?)? validator;

  @override
  State<ConfirmPasswordTextFormField> createState() =>
      _ConfirmPasswordTextFormFieldState();
}

class _ConfirmPasswordTextFormFieldState
    extends State<ConfirmPasswordTextFormField> {
  bool _obscureTextLogin = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: DefaultTextFormField(
        currentController: widget.currentController,
        currentFocusNode: widget.currentFocusNode,
        nextFocusNode: widget.nextFocusNode,
        margin: widget.margin,
        hint: widget.hint ?? 'password'.tr(),
        obscureText: _obscureTextLogin,
        maxLines: 1,
        suffixIcon: GestureDetector(
          onTap: _toggleLogin,
          child: Icon(
            _obscureTextLogin
                ? FontAwesomeIcons.eyeSlash
                : FontAwesomeIcons.eye,
            size: 18,
            color: Colors.black,
          ),
        ),
        validator: (confPassword) => Validator()
            .validateConfPassword(widget.passwordController.text, confPassword),
      ),
    );
  }

  void _toggleLogin() => setState(() => _obscureTextLogin = !_obscureTextLogin);
}
