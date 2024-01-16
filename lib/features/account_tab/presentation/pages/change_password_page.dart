import '../../../auth/presentation/blocs/auth_cubit/auth_cubit.dart';
import '../../../../shared_widgets/stateless/inner_appbar.dart';
import '../../../../shared_widgets/stateless/subtitle_text.dart';

import '/core/utils/navigator_helper.dart';
import '/shared_widgets/stateless/custom_app_page.dart';
import '/shared_widgets/stateful/default_button.dart';
import '/shared_widgets/other/show_snack_bar.dart';
import '/shared_widgets/text_fields/confirm_password_text_field.dart';
import '/shared_widgets/text_fields/password_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordPage extends StatefulWidget {
  static const routeName = '/ChangePasswordPage';
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _oldPasswordTextController;
  late final TextEditingController _newPasswordTextController;
  late final TextEditingController _confirmPasswordTextController;
  late final FocusNode _oldPasswordFocusNode;
  late final FocusNode _newPasswordFocusNode;
  late final FocusNode _confirmPasswordFocusNode;

  bool _isAutoValidating = false;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _oldPasswordTextController = TextEditingController();
    _newPasswordTextController = TextEditingController();
    _confirmPasswordTextController = TextEditingController();
    _oldPasswordFocusNode = FocusNode();
    _newPasswordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _oldPasswordTextController.dispose();
    _newPasswordTextController.dispose();
    _confirmPasswordTextController.dispose();
    _oldPasswordFocusNode.dispose();
    _newPasswordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.isError)
          showSnackBar(context, message: state.errorMessage);
        else if (state.isChangePasswordSuccess) _goBackToAccountPage(context);
      },
      child: Builder(
        builder: (context) => CustomAppPage(
          safeTop: true,
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const InnerPagesAppBar(
                    label: 'change_password',
                  ),
                  const SizedBox(height: 16.0),
                  _buildChangePasswordSubText(context),
                  const SizedBox(height: 16.0),
                  _buildForm(),
                  const Spacer(),
                  _buildSavePasswordButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChangePasswordSubText(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: SubtitleText(text: 'change_password_sub'),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      autovalidateMode: _isAutoValidating
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: Column(
        children: [
          PasswordTextFormField(
            currentFocusNode: _oldPasswordFocusNode,
            currentController: _oldPasswordTextController,
            hint: 'old_password'.tr(),
          ),
          const SizedBox(height: 16.0),
          PasswordTextFormField(
            currentFocusNode: _newPasswordFocusNode,
            currentController: _newPasswordTextController,
            hint: 'new_password'.tr(),
          ),
          const SizedBox(height: 16.0),
          ConfirmPasswordTextFormField(
            currentFocusNode: _confirmPasswordFocusNode,
            currentController: _confirmPasswordTextController,
            passwordController: _newPasswordTextController,
            hint: 'confirm_password'.tr(),
          )
        ],
      ),
    );
  }

  Widget _buildSavePasswordButton(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return DefaultButton(
      label: 'save_new_password'.tr(),
      isExpanded: true,
      onPressed: () {
        if (_isNotValid()) return;
        authCubit.changePassword(_oldPasswordTextController.text.trim(),
            _newPasswordTextController.text.trim());
      },
    );
  }

  bool _isNotValid() {
    if (!_formKey.currentState!.validate()) {
      setState(() => _isAutoValidating = true);
      return true;
    }
    return false;
  }

  void _goBackToAccountPage(BuildContext context) {
    NavigatorHelper.of(context).pop(true);

    showSnackBar(context, message: 'password_changed');
  }
}
