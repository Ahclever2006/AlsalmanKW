import '../../../../shared_widgets/stateless/inner_appbar.dart';

import '../blocs/auth_cubit/auth_cubit.dart';
import '/core/utils/navigator_helper.dart';
import '/di/injector.dart';
import '/res/style/app_colors.dart';
import '/shared_widgets/stateless/custom_app_page.dart';
import '/shared_widgets/stateful/default_button.dart';
import '/shared_widgets/other/show_snack_bar.dart';
import '/shared_widgets/text_fields/email_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'forget_password_success.dart';

class ForgetPasswordPage extends StatefulWidget {
  static const routeName = '/ForgetPasswordPage';
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailTextController;
  late final FocusNode _emailFocusNode;

  bool _isAutoValidating = false;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _emailTextController = TextEditingController();
    _emailFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Injector().authCubit,
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.isError)
            showSnackBar(context, message: state.errorMessage);
          else if (state.isAuthSuccess) _goToSuccessPage(context);
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
                    const InnerPagesAppBar(label: 'forget_password_title'),
                    const SizedBox(height: 16.0),
                    _buildForgetPasswordSubText(context),
                    const SizedBox(height: 16.0),
                    _buildForm(),
                    const Spacer(),
                    _buildSendEmailButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForgetPasswordSubText(BuildContext context) {
    return Text(
      'forget_password_sub'.tr(),
      style: Theme.of(context)
          .textTheme
          .bodyText1!
          .copyWith(color: AppColors.GREY_DARK_COLOR),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      autovalidateMode: _isAutoValidating
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: EmailTextFormField(
        currentFocusNode: _emailFocusNode,
        currentController: _emailTextController,
      ),
    );
  }

  Widget _buildSendEmailButton(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return DefaultButton(
      label: 'send_email'.tr(),
      isExpanded: true,
      onPressed: () async {
        if (_isNotValid()) return;
        await authCubit.forgetPassword(_emailTextController.text.trim());
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

  void _goToSuccessPage(BuildContext context) => NavigatorHelper.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) {
        return const ForgetPasswordSuccessPage();
      }));
}
